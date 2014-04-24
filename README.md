gbrowse2-contrib
================

Configuration and miscellaneous support files for `AIP` project `GBrowse2` installation

## Installing GBrowse2

For the `AIP` project, please following the steps outlined below for the setup and installation of the app:

    ## server: columbia
    $ cd /opt/www/araport

    ### clone the gbrowse2-contrib repo
    ### remember to clone `--recursive` to get the submodule as well
    ### submodule `GBrowse` points to the latest release (https://github.com/GMOD/GBrowse/releases)
    $ git clone --recursive https://github.com/Arabidopsis-Information-Portal/gbrowse-contrib

    ### run the GBrowse2 setup (as a non-root user)
    $ cd GBrowse
    $ perl Build.PL --install_base=/opt/www/araport

    ### run the tests
    $ ./Build test

    ### configuration during tests
    Directory for GBrowse's config and support files? [/opt/www/araport/etc/gbrowse2]
    Directory for GBrowse's static images & HTML files? [/opt/www/araport/htdocs] /opt/www/araport/htdocs/gbrowse2
    Directory for GBrowse's temporary data [/opt/www/araport/tmp/gbrowse2]
    Directory for GBrowse's sessions, uploaded tracks and other persistent data [/opt/www/araport/lib/gbrowse2] /opt/www/araport/data/gbrowse2
    Directory for GBrowse's example databases [/opt/www/araport/lib/gbrowse2/databases] /opt/www/araport/data/gbrowse2_dbs
    Directory for GBrowse's CGI script executables? [/var/www/cgi-bin/gb2] /opt/www/araport/cgi-bin/gb2
    Internet port to run demo web site on (for demo)? [8000] 80
    Apache loadable module directory (for demo)? [/etc/httpd/modules] /opt/software/apache2/modules
    User account under which Apache daemon runs? [apache] daemon
    Automatically update Apache config files to run GBrowse? [y] n
    Automatically update system config files to run gbrowse-slave? [y] n

    ### run the install step
    $ ./Build install

If all goes well, GBrowse2 and its dependencies should have been installed sucessfully. Before starting up the app, minor changes need to be made to the `cgi` scripts. Please follow the steps below:

    $ cd /opt/www/araport/gbrowse2-contrib

    ### copy the modified cgi scripts from the contrib to the cgi-bin
    ### the shebang line has been modified to point to the correct version of PERL
    ### also, one line has been added to every cgi script to update the PERL @INC PATH
    $ cp cgi-bin/gb2/* ../cgi-bin/gb2/.

Now, point the web browser to <http://araport-dev.jcvi.org/gbrowse/> to check that the app is functioning properly.

## Loading data into GBrowse2

Before data can be loaded into `GBrowse2`, please follow the instructions for setting up the data area from here: [araport-contrib](http://github.com/arabidopsis-information-portal/araport-contrib/blob/master/README.md)

Once the `GBrowse2` set up is complete and the data has been downloaded to the right location, refer to the following steps to load data:

    ### server: columbia
    $ cd /opt/www/araport/gbrowse2-contrib

    ### edit the loading script to add the necessary DB connection credentials
    ### make sure postgres database has been created and accessible
    $ vim gbrowse2-load.sh

    ### run the loading script (this takes close to 9 hours to complete for the full dataset)
    $ ./gbrowse2-load.sh > gbrowse2-load.log 2> gbrowse2-load.err

    ### after the loading, place the core and track configuration file(s) in `etc/gbrowse2`
    $ cp etc/gbrowse2/*.conf ../etc/gbrowse2/.

    ### copy the GBrowseHTML.pm module into the lib area
    ### this is necessary to insert Google Analytics tracking into the gbrowse html head
    $ cp lib/5.16.1/GBrowseHTML.pm ../lib/5.16.1

    ### copy the InterMineWS.pm module into the lib area
    ### this is necessary for the mouse-over balloon popups to pull data from ThaleMine
    $ cp lib/5.16.1/InterMineWS.pm ../lib/5.16.1

Point the web browser to <http://araport-dev.jcvi.org/gb2/gbrowse/arabidopsis> to check that the loaded data appears in the genome browser.

## JCVI specific code/data migration workflow to production

##### Migrating to test

This involves making use of a command line mechanism to push the app from dev --> test.

    ### prepare to push from dev --> test

    ### request the JCVI IT/DBA team to copy database from dev --> test

    ### edit `tarinclude` file which lists relative paths to code that needs to be migrated
    ### Example line(s) in `tarinclude`:
        ./htdocs/gbrowse2
        ./cgi-bin/gb2
        ./etc
        ./lib
        ./include

    $ cd /opt/www/araport
    $ vim tarinclude

    ### invoke push from dev --> test, this step only copies the app code
    $ make

Point the web browser to <http://araport-test.jcvi.org/gb2/gbrowse/arabidopsis> to check that the app is functioning properly.

##### Synching with production

This mechanism is regulated by `rdist`, a remote file distribution client, which is controlled by a configuration file, called a `distfile`.

    ### prepare to synch test with prod

    ### request the JCVI IT/DBA team to copy database from test --> production

    ### to check the areas that are set up to be synched, invoke the following command:
    $ cd /opt/www/araport
    $ make getdistfile
    ### this will retrieve a file called `distfile.araport`
    ### contains a list of directories to be mirrored (and a list of excluded directories as well)

    ### synch the application
    $ make test2pro

Once the synch is complete, point the web browser to <https://apps.araport.org/gb2/gbrowse/arabidopsis> to check that the app is functioning properly.
