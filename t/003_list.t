# -*- perl -*-
use strict;
use warnings;
use Test::More tests => 20;

BEGIN { use_ok( 'Geo::Google::Latitude' ); }

my $gl=Geo::Google::Latitude->new;
isa_ok($gl, 'Geo::Google::Latitude');

my @ref=$gl->getList;
is(@ref, 0, '$gl->getList length');

my $id="7832225593622256926";
my $ref=$gl->getList($id, $id, $id, 3333, 4444);
isa_ok($ref, 'ARRAY', '$gl->getList');
is(@$ref, 5, '$gl->getList length');

isa_ok($ref->[0], 'Geo::Google::Latitude::Badge');
isa_ok($ref->[1], 'Geo::Google::Latitude::Badge');
isa_ok($ref->[2], 'Geo::Google::Latitude::Badge');
isa_ok($ref->[3], 'Geo::Google::Latitude::Badge');
isa_ok($ref->[4], 'Geo::Google::Latitude::Badge');

is($ref->[0]->id, $id, 'id method');
is($ref->[1]->id, $id, 'id method');
is($ref->[2]->id, $id, 'id method');
is($ref->[3]->id, 3333, 'id method');
is($ref->[4]->id, 4444, 'id method');

ok(!$ref->[0]->error, 'id method');
ok(!$ref->[1]->error, 'id method');
ok(!$ref->[2]->error, 'id method');
ok($ref->[3]->error, 'id method');
ok($ref->[4]->error, 'id method');
