package InterMineWS;
use strict;
use warnings;

sub balloon_popup {
    my ($feature) = @_;
    my $thalemineURL = "$ENV{SERVER_NAME}/thalemine";
    my @elems = ('primaryIdentifier', 'Alias', 'curatorSummary', 'computationalDescription');

    my $primaryIdentifier = $feature->name;
    my ($type, $source) = $feature->type =~ /^(\S+):(\S+)$/;
    $type =~ s/(\S+)/\U$1/gs;
    $type =~ s/_(\S{1})/\U$1/gs;

    use Webservice::InterMine;
    my $service = Webservice::InterMine->get_service("$thalemineURL");
    my $qresult = $service->new_query(class => $type)->select('*')
      ->where(primaryIdentifier => [$primaryIdentifier])->first;
    my @results = ();
    foreach my $elem (@elems) {
        push @results, $qresult->{$elem} if (defined $qresult->{$elem});
    }
    return "<center>" . (join "<br />", @results) . "</center>";
}

1;
