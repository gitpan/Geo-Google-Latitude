# -*- perl -*-
use strict;
use warnings;
use Test::More tests => 9;

BEGIN { use_ok( 'Geo::Google::Latitude::Badge' ); }
BEGIN { use_ok( 'Geo::Google::Latitude' ); }

my $gl;

$gl=Geo::Google::Latitude->new;
isa_ok($gl, 'Geo::Google::Latitude');
can_ok($gl, qw{new initialize});
can_ok($gl, qw{get getList});
can_ok($gl, qw{url});

$gl=Geo::Google::Latitude::Badge->new;
isa_ok($gl, 'Geo::Google::Latitude::Badge');
can_ok($gl, qw{new initialize});
can_ok($gl, qw{id error status lat lon});
