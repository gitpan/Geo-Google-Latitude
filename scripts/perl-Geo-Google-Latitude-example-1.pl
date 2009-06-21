#!/usr/bin/perl

=head1 NAME

perl-Geo-Google-Latitude-example-1.pl - Simple Geo::Google::Latitude example

=cut

use strict;
use warnings;
use Geo::Google::Latitude;
use Data::Dumper;

my $gl=Geo::Google::Latitude->new;
my $id="7832225593622256926";
my $badge=$gl->get($id);
print Dumper([$badge->point]);
printf "Lat: %s, Lon %s\n", $badge->point->latlon;
