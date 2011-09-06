#!/usr/bin/perl
use strict;
use warnings;
use Sys::RunAlways;
use Geo::Google::Latitude 0.06; #badge->error method
use DBIx::Array::Connect;
use DateTime;

=head1 NAME

Geo-Google-Latitude-tracker.pl - Geo::Google::Latitude Database Tracker

=head2 SYNTAX

  Geo-Google-Latitude-tracker.pl [user_id] [user_id ...]

=cut

my $debug=0;
my $gl=Geo::Google::Latitude->new;
my $sdb=DBIx::Array::Connect->new->connect("latitude");

my %time=$sdb->sqlarray(&time_sql);
if ($debug) {
  print(join("|", $_ => $time{$_}), "\n") foreach sort keys %time;
}
$time{$_}=0 foreach @ARGV;
my $first=1;

while ($first or sleep 40) {
  $first=0;
  my @badge=$gl->getList(keys %time);
  foreach my $badge (@badge) {
    next unless defined($badge);
    next if $badge->error;
    next unless defined($badge->point);
    next unless defined($badge->point->time);
    next unless $badge->point->time > 0;
    print join("|", DateTime->now, 
                    $badge->id,
                    $badge->point->datetime,
                    $badge->point->time,
                    $badge->point->latlon,
                    $badge->point->ehorizontal), "\n"
      if $debug;
    if ($badge->point->time != $time{$badge->id}) {
      $sdb->insert(&insert_sql, $badge->id,
                            $badge->point->time,
                            $badge->point->lat,
                            $badge->point->lon,
                            $badge->point->ehorizontal);
      $time{$badge->id}=$badge->point->time;
    }
  }
}

sub insert_sql {
  return q{
           INSERT
             INTO badge_track
                ( user_id
                , timeStamp
                , lat
                , lon
                , accuracyInMeters)
           VALUES (?, ?, ?, ?, ?)
          };
}

sub time_sql {
  return q{
           SELECT user_id, MAX(timeStamp)
             FROM badge_track
         GROUP BY user_id
          };
}

__END__

$ mysqldump -p latitude
-- MySQL dump 10.10
-- Host: localhost    Database: latitude
-- Server version       5.0.27

CREATE TABLE badge_track (
  track_id bigint(20) unsigned NOT NULL auto_increment,
  created_dt timestamp NOT NULL default CURRENT_TIMESTAMP,
  user_id varchar(50) NOT NULL,
  timeStamp double unsigned NOT NULL,
  lat double NOT NULL,
  lon double NOT NULL,
  accuracyInMeters double default NULL,
  PRIMARY KEY  (track_id),
  UNIQUE KEY ak1_badge_track (user_id,timeStamp)
);

CREATE TABLE  user (
  user_id varchar(50) NOT NULL,
  user_label varchar(50) NOT NULL,
  PRIMARY KEY  (user_id)
);
