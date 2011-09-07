# -*- perl -*-
use strict;
use warnings;
use Test::More tests => 12;

BEGIN { use_ok( 'Geo::Google::Latitude' ); }

my $gl=Geo::Google::Latitude->new;
isa_ok($gl, 'Geo::Google::Latitude');

my $id="7832225593622256926";
my $badge=$gl->get($id);
ok(!$badge->error, "HTTP error");
is($badge->status, "200 OK", "HTTP status");
isa_ok ($badge, 'Geo::Google::Latitude::Badge');
isa_ok ($badge->point, 'GPS::Point');

is($badge->id, $id, '$badge->id');
is($badge->lat, $badge->point->lat, '$badge->lat');
is($badge->lon, $badge->point->lon, '$badge->lon');
is($badge->lon, $badge->point->lon, '$badge->lon');
like($badge->photoImg, qr{<img[^<>]*>}, '$badge->photoImg');
like($badge->placardImg, qr{<img[^<>]*>}, '$badge->photoImg');
