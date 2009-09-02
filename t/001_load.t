# -*- perl -*-

# t/001_load.t - check module loading and create testing directory

use Test::More tests => 6;

BEGIN { use_ok( 'Geo::Google::Latitude::Base' ); }
BEGIN { use_ok( 'Geo::Google::Latitude::Badge' ); }
BEGIN { use_ok( 'Geo::Google::Latitude' ); }

my $object;

$object = Geo::Google::Latitude::Base->new ();
isa_ok ($object, 'Geo::Google::Latitude::Base');

$object = Geo::Google::Latitude::Badge->new ();
isa_ok ($object, 'Geo::Google::Latitude::Badge');

$object = Geo::Google::Latitude->new ();
isa_ok ($object, 'Geo::Google::Latitude');
