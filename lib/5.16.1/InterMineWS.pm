package InterMineWS;
use strict;
use warnings;

sub balloon_popup {
    my ($feature)    = @_;
    my $thalemineURL = "$ENV{SERVER_NAME}/thalemine";
    my %elements        = (
        'symbol'                   => 'Gene Symbol',
        'alias'                    => 'Gene Aliases',
        'curatorSummary'           => 'Curator Summary',
        'computationalDescription' => 'Computational Description',
        'confClass'                => 'Confidence Class (scale of 1-10)',
        'confRating'               => 'Confidence Rating (scale of 1-5 stars)'
    );

    my $primaryIdentifier = $feature->name;
    my ($type, $source) = $feature->type =~ /^(\S+):(\S+)$/;
    $type =~ s/(\S+)/\u$1/gs;
    $type =~ s/_(\S{1})/\u$1/gs;

    use Webservice::InterMine;
    my $service = Webservice::InterMine->get_service("$thalemineURL");
    my $query = $service->new_query(class => $type);
    $query->add_view(qw(*));
    $query->add_constraint(
        path  => "$type.primaryIdentifier",
        op    => "=",
        value => "$primaryIdentifier",
        code  => "A",
    );
    my $ri = $query->results_iterator();
    die $ri->status_line unless $ri->is_success;

    my @resultsHtml = ();
    while(my $row = <$ri>) {
        foreach my $column (keys %elements) {
            if (defined $row->{$column}) {
                push @resultsHtml, '<tr class="popuptbl">', "<td><strong>$elements{$column}</strong></td>",
                  "<td>" . $row->{$column} . "</td>", "</tr>";
            }
        }
    }
    $ri->close();

    if(scalar @resultsHtml > 0) {
        unshift @resultsHtml, "<table border=1>";
        push @resultsHtml, "</table>";
        return join "", @resultsHtml;
    }
}

1;
