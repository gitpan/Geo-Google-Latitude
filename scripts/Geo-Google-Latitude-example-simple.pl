#!/usr/bin/perl

=head1 NAME

Geo-Google-Latitude-example-simple.pl - Geo::Google::Latitude Simple Example

=cut

use strict;
use warnings;
use Geo::Google::Latitude;

my $gl=Geo::Google::Latitude->new;
my $id=shift || "7832225593622256926";
my $badge=$gl->get($id);

die(sprintf("HTTP Error: %s", $badge->status)) if $badge->error;

printf "Lat: %s, Lon %s\n", $badge->point->latlon;
