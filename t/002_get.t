# -*- perl -*-

# t/001_load.t - check module loading and create testing directory

use Test::More tests => 4;

BEGIN { use_ok( 'Geo::Google::Latitude' ); }

my $gl = Geo::Google::Latitude->new ();
isa_ok ($gl, 'Geo::Google::Latitude');

my $id="7832225593622256926";
my $badge=$gl->get($id);
isa_ok ($badge, 'Geo::Google::Latitude::Badge');

isa_ok ($badge->point, 'GPS::Point');

