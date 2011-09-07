#!/usr/bin/perl
use strict;
use warnings;
use DBIx::Array::Connect qw{};
use Geo::GoogleEarth::Pluggable;
use CGI;
use CGI::Carp qw(fatalsToBrowser);

=head1 NAME

Geo-Google-Latitude-database-GoogleEarth.cgi - Geo::Google::Latitude to Geo::GoogleEarth::Pluggable Example

=cut

my $visible=3;
my $cgi=CGI->new;
my $dbx=DBIx::Array::Connect->new->connect("latitude");
my $document=Geo::GoogleEarth::Pluggable->new(name=>"Geo::Google::Latitude");
my $script=$cgi->url(-full=>1, -path_info=>0, -query=>0);
if ($cgi->param("user")) {
  if ($cgi->param("date")) {
    foreach my $point ($dbx->sqlarrayhash(&points_sql, $cgi->param("user"), $cgi->param("date"))) {
      $document->Point(name=>sprintf("ID: %s - %s", $point->{"id"}, $point->{"time"}),
                           lat=>$point->{"lat"},
                           lon=>$point->{"lon"});
    }
  } else {
    foreach my $date ($dbx->sqlarray(&dates_sql, $cgi->param("user"))) {
      my $visibility=$visible-- > 0 ? 1 : 0;
      $document->NetworkLink(
                     name=>$date,
                     visibility=>$visibility,
                     url=>sprintf("%s?user=%s;date=%s",
                            $script, $cgi->param("user"), $date));
    } 
  }
} else {
  foreach my $user ($dbx->sqlarrayhash(&users_sql)) {
    $document->NetworkLink(
                   name=>sprintf("User: %s", $user->{"label"}),
                   open=>1,
                   url=>sprintf("%s?user=%s",
                          $script, $user->{"id"}));
  }
}
print $document->header,
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
