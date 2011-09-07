#!/usr/bin/perl
use strict;
use warnings;
use Geo::Google::Latitude;

=head1 NAME

Geo-Google-Latitude-get.pl - Geo::Google::Latitude Simple Example

=cut

my $gl=Geo::Google::Latitude->new;
my $id=shift || "7832225593622256926";
my $badge=$gl->get($id);

die(sprintf("Error: %s\n", $badge->status)) if $badge->error;

printf "Lat: %s, Lon %s\n", $badge->point->latlon;
