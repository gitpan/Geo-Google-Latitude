use ExtUtils::MakeMaker;
WriteMakefile(
    NAME         => 'Geo::Google::Latitude',
    VERSION_FROM => 'lib/Geo/Google/Latitude.pm', # finds \$VERSION
    AUTHOR       => 'Michael R. Davis (domain=>michaelrdavis,tld=>com,account=>perl)',
    ABSTRACT     => 'Retrieves a Google Latitude Public Location Badge',
    PREREQ_PM    => {
                      strict        => 0,
                      warnings      => 0,
                      base          => 0,
                     'Test::Simple' => 0.44,
                     'GPS::Point'   => 0,
                     'URI'          => 0,
                     'LWP::Simple'  => 0, #libwww-perl
                     'JSON::XS'     => 0,
                    },
);
