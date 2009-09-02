#!/usr/bin/perl

=head1 NAME

Geo-Goole-Latitude-database.pl - Geo::Google::Latitude MySQL Example

=cut

use strict;
use warnings;
use Geo::Google::Latitude qw{};
use DBIx::Array qw{};
use DateTime qw{};
use File::Basename qw{basename};
use File::Slurp qw{write_file};

my $basename=basename($0, ".pl");
my $pidfile="/var/run/$basename.pid";
write_file($pidfile, "$$\n") ;

my $debug=shift||0;
my $gl=Geo::Google::Latitude->new;
my $dba = DBIx::Array->new();
my $connection="DBI:mysql:database=latitude;host=localhost";
my $user="google";
my $pass="latitude";
my %opt=(AutoCommit=>1, RaiseError=>1);
$dba->connect($connection, $user, $pass, \%opt);

my %time=$dba->sqlarray(&time_init);
$time{$_}=0 foreach @ARGV;
my $first=1;

while ($first or sleep 60) {
  $first=0;
  foreach my $id (keys %time) {
    my $badge=$gl->get($id);
    next unless defined($badge->point->time) and $badge->point->time > 0;
    if ($badge->point->time != $time{$id}) {
      print join("|", DateTime->now, 
                      $id,
                      $badge->point->datetime,
                      $badge->point->latlon,
                      $badge->point->ehorizontal), "\n"
        if $debug;
      $dba->execute(&insert, $id,
                             $badge->point->time,
                             $badge->point->lat,
                             $badge->point->lon,
                             $badge->point->ehorizontal);
      $time{$id}=$badge->point->time;
    }
  }
}

sub insert {
  return q{
           INSERT INTO badge_track (user_id, timeStamp,
                                    lat, lon, accuracyInMeters)
                            VALUES (?, ?, ?, ?, ?)
          };
}

sub time_init {
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
