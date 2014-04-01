package GBrowseHTML;

use strict;
use warnings;

sub analytics {
    my $domain = "araport.org";
    my $tracker = "UA-48916712-1";
    my $analytics = join(
        "\n",
        qq#
            <!-- google analytics -->
            <script type="text/javascript">
            var is_production = true;
            var dev_test = /(-dev)|(-test)/;
            var hostname = location.hostname;

            if(hostname.search(dev_test) != -1) {
                is_production = false;
            } // end if(hostname.search(dev_test) != -1)

            if(is_production) {
                (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
                (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
                m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
                })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

                ga('create', '$tracker', '$domain');
                ga('require', 'linkid', 'linkid.js');
                ga('send', 'pageview');
            } // end if(is_production)
            </script>
        #
    );
    return $analytics;
}

sub header {
    return analytics();
}

sub footer {
    my $funding = '<hr /><p style="text-align: center;">
                    The Arabidopsis Information Portal is funded by a grant from the National Science Foundation
                    (<a href="http://www.nsf.gov/awardsearch/showAward?AWD_ID=1262414" target="_blank">#DBI-1262414</a>)<br />
                    and co-funded by a grant from the Biotechnology and Biological Sciences Research Council
                    (<a href="http://www.bbsrc.ac.uk/pa/grants/AwardDetails.aspx?FundingReference=BB/L027151/1" target="_blank">BB/L027151/1</a>)
                </p>';

    return $funding;
}
