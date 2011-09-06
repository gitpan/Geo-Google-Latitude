# -*- perl -*-

use strict;
use warnings;
use Test::More tests => 4;

BEGIN { use_ok( 'Geo::Google::Latitude::Badge' ); }
BEGIN { use_ok( 'Geo::Google::Latitude' ); }

my $object;

$object = Geo::Google::Latitude::Badge->new ();
isa_ok ($object, 'Geo::Google::Latitude::Badge');

$object = Geo::Google::Latitude->new ();
isa_ok ($object, 'Geo::Google::Latitude');
