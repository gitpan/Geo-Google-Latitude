#!/usr/bin/perl

=head1 NAME

Geo-Goole-Latitude-database-GoogleEarth.pl - Geo::Google::Latitude MySQL Example

=cut

use strict;
use warnings;
use DBIx::Array qw{};
use Geo::GoogleEarth::Document;
use CGI;
use CGI::Carp qw(fatalsToBrowser);

my $visible=3;

my $cgi=CGI->new;

my $dba = DBIx::Array->new();
my $connection="DBI:mysql:database=latitude;host=localhost";
my $login="google";
my $pass="latitude";
my %opt=(AutoCommit=>1, RaiseError=>1);
$dba->connect($connection, $login, $pass, \%opt);

my $document=Geo::GoogleEarth::Document->new(name=>"Geo::Google::Latitude");
my $script=$cgi->url(-full=>1, -path_info=>0, -query=>0);
if ($cgi->param("user")) {
  if ($cgi->param("date")) {
    foreach my $point ($dba->sqlarrayhash(&points_sql, $cgi->param("user"), $cgi->param("date"))) {
      $document->Placemark(name=>sprintf("ID: %s - %s", $point->{"id"}, $point->{"time"}),
                           lat=>$point->{"lat"},
                           lon=>$point->{"lon"});
    }
  } else {
    foreach my $date ($dba->sqlarray(&dates_sql, $cgi->param("user"))) {
      my $visibility=$visible-- > 0 ? 1 : 0;
      $document->NetworkLink(
                     name=>$date,
                     visibility=>$visibility,
                     url=>sprintf("%s?user=%s;date=%s",
                            $script, $cgi->param("user"), $date));
    } 
  }
} else {
  foreach my $user ($dba->sqlarrayhash(&users_sql)) {
    $document->NetworkLink(
                   name=>sprintf("User: %s", $user->{"label"}),
                   open=>1,
                   url=>sprintf("%s?user=%s",
                          $script, $user->{"id"}));
  }
}
print $cgi->header('text/xml'),
      $document->render;

sub users_sql {
  return qq{
            SELECT DISTINCT
                   badge_track.user_id AS "id", 
                   COALESCE(user.user_label, badge_track.user_id) AS "label"
              FROM badge_track LEFT JOIN user
                     ON badge_track.user_id = user.user_id
          ORDER BY COALESCE(user.user_label, badge_track.user_id);
           };
}

sub dates_sql {
  return qq{
            SELECT DISTINCT
                   DATE(FROM_UNIXTIME(timeStamp))
              FROM badge_track
             WHERE user_id = ?
          ORDER BY DATE(FROM_UNIXTIME(timeStamp)) DESC
           };
}

sub points_sql {
  return q{
           SELECT track_id                 AS "id",
                  lat                      AS "lat",
                  lon                      AS "lon",
                  FROM_UNIXTIME(timeStamp) AS "time"
             FROM badge_track
            WHERE user_id = ?
              AND DATE(FROM_UNIXTIME(timeStamp)) = ?
         ORDER BY FROM_UNIXTIME(timeStamp) DESC
          };
}
