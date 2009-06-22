#!/usr/bin/perl

=head2 NAME

perl-Geo-Google-Latitude-example-1.pl - Geo::Google::Latitude Example 2

=cut

use strict;
use warnings;
use Geo::Google::Latitude;
use Data::Dumper;

my $gl=Geo::Google::Latitude->new;
my $id=shift || "7832225593622256926";
my $badge=$gl->get($id);
printf "Time: %s, Lat: %s, Lon %s\n", $badge->point->datetime,
                                      $badge->point->latlon;
