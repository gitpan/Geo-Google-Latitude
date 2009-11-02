#!/usr/bin/perl

=head1 NAME

Geo-Google-Latitude-example-datetime.pl - Geo::Google::Latitude Simple Example With DateTime

=cut

use strict;
use warnings;
use Geo::Google::Latitude;

my $gl=Geo::Google::Latitude->new;
my $id=shift || "7832225593622256926";
my $badge=$gl->get($id);

die(sprintf("HTTP Error: %s", $badge->status)) if $badge->error;

printf "Time: %s, Lat: %s, Lon %s\n", $badge->point->datetime,
                                      $badge->point->latlon;
