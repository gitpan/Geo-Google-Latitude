use ExtUtils::MakeMaker;
WriteMakefile(
    NAME         => 'Geo::Google::Latitude',
    VERSION_FROM => 'lib/Geo/Google/Latitude.pm',
    AUTHOR       => 'Michael R. Davis (domain=>michaelrdavis,tld=>com,account=>perl)',
    ABSTRACT_FROM=> 'lib/Geo/Google/Latitude.pm',
    PREREQ_PM    => {
                     'Test::Simple'    => 0.44,
                     'Package::New'    => 0,
                     'URI'             => 0,
                     'LWP::UserAgent'  => 0, #libwww-perl
                     'JSON::XS'        => 0,
                     'GPS::Point'      => 0,
                    },
);
