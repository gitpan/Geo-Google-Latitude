#!/usr/bin/perl
use strict;
use warnings;
use Geo::Google::Latitude;
use DateTime qw{};

=head1 NAME

Geo-Google-Latitude-loop.pl - Geo::Google::Latitude Loop Example

=cut

my $gl=Geo::Google::Latitude->new;
my $id=shift || "7832225593622256926";
print "Google Latitude User ID: $id\n";
my $time="0";
while (!$time or sleep 5) {
  my $badge=$gl->get($id); #isa L<Geo::Google::Latitude::Badge>
  next if $badge->error;
  print join("|", DateTime->now, $badge->point->datetime,
                  $badge->point->latlon, $badge->point->ehorizontal), "\n";
  $time=$badge->point->time;
}
