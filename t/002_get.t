# -*- perl -*-

# t/001_load.t - check module loading and create testing directory

use Test::More tests => 13;

BEGIN { use_ok( 'Geo::Google::Latitude' ); }

my $gl = Geo::Google::Latitude->new ();
isa_ok ($gl, 'Geo::Google::Latitude');

my $id="7832225593622256926";
my $badge=$gl->get($id);
isa_ok ($badge, 'Geo::Google::Latitude::Badge');

isa_ok ($badge->point, 'GPS::Point');

is($badge->id, '7832225593622256926', '$badge->id');
is($badge->lat, $badge->point->lat, '$badge->lat');
is($badge->lon, $badge->point->lon, '$badge->lon');
is($badge->lon, $badge->point->lon, '$badge->lon');
#is($badge->photoImg, '<img />', '$badge->photoImg');
#is($badge->placardImg, '<img />', '$badge->photoImg');

my $ref=$gl->getList($id, $id, $id);
isa_ok($ref, 'ARRAY', '$gl->getList');
is(@$ref, 3, '$gl->getList length');
isa_ok ($ref->[0], 'Geo::Google::Latitude::Badge');
isa_ok ($ref->[1], 'Geo::Google::Latitude::Badge');
isa_ok ($ref->[2], 'Geo::Google::Latitude::Badge');
