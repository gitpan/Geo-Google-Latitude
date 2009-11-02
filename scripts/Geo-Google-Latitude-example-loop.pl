#!/usr/bin/perl

=head1 NAME

perl-Geo-Google-Latitude-example-loop.pl - Geo::Google::Latitude Example Loop

=cut

use strict;
use warnings;
use Geo::Google::Latitude;
use DateTime qw{};
my $gl=Geo::Google::Latitude->new;
my $id=shift || "7832225593622256926";
print "Google Latitude User ID: $id\n";
my $time="0";
while (!$time or sleep 60) {
  my $badge=$gl->get($id); #isa L<Geo::Google::Latitude::Badge>
  next if $badge->error;
  next unless defined($badge->point->time) and $badge->point->time > 0;
  if ($badge->point->time != $time) {
    print join("|", DateTime->now, $badge->point->datetime,
                    $badge->point->latlon, $badge->point->ehorizontal), "\n";
    $time=$badge->point->time;
  }
}
