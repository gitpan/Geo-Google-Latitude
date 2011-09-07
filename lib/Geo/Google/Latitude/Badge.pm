package Geo::Google::Latitude::Badge;
use strict;
use warnings;
use base qw{Package::New};
use GPS::Point;

our $VERSION='0.08';

=head1 NAME

Geo::Google::Latitude::Badge - Google Latitude Public Location Badge Object

=head1 SYNOPSIS

  use Geo::Google::Latitude;
  my $gl=Geo::Google::Latitude->new;
  my $id=7832225593622256926;
  my $badge=$gl->get($id); #ISA Geo::Google::Latitude::Badge

=head1 DESCRIPTION

=head1 USAGE

=head1 METHODS

=head2 id

=cut

sub id {
  my $self=shift;
  return $self->{"properties"}->{"id"};
}

=head2 error

Returns if there was an HTTP error

=cut

sub error {
  my $self=shift;
  return $self->{"error"};
}

=head2 status

Return the HTTP status line

=cut

sub status {
  my $self=shift;
  return $self->{"status"};
}

=head2 lat

=cut

sub lat {
  my $self=shift;
  return $self->{"geometry"}->{"coordinates"}->[1];
}

=head2 lon

=cut

sub lon {
  my $self=shift;
  return $self->{"geometry"}->{"coordinates"}->[0];
}

=head2 timeStamp

=cut

sub timeStamp {
  my $self=shift;
  return $self->{"properties"}->{"timeStamp"};
}

=head2 accuracyInMeters

=cut

sub accuracyInMeters {
  my $self=shift;
  return $self->{"properties"}->{"accuracyInMeters"};
}

=head2 reverseGeocode

=cut

sub reverseGeocode {
  my $self=shift;
  return $self->{"properties"}->{"reverseGeocode"};
}

=head2 photoImg

Returns the <img /> tag for the photo.

=cut

sub photoImg {
  my $self=shift;
  return sprintf(qq{<img src="%s" height="%s" width="%s" alt="%s"/>}, $self->photoUrl, $self->photoHeight, $self->photoWidth, $self->id);
}

=head2 photoUrl

=cut

sub photoUrl {
  my $self=shift;
  return $self->{"properties"}->{"photoUrl"};
}

=head2 photoWidth

=cut

sub photoWidth {
  my $self=shift;
  return $self->{"properties"}->{"photoWidth"};
}

=head2 photoHeight

=cut

sub photoHeight {
  my $self=shift;
  return $self->{"properties"}->{"photoHeight"};
}

=head2 placardImg

Returns the <img /> tag for the placard.

=cut

sub placardImg {
  my $self=shift;
  return sprintf(qq{<img src="%s" height="%s" width="%s" alt="%s"/>}, $self->placardUrl, $self->placardHeight, $self->placardWidth, $self->reverseGeocode);
}

=head2 placardUrl

=cut

sub placardUrl {
  my $self=shift;
  return $self->{"properties"}->{"placardUrl"};
}

=head2 placardWidth

=cut

sub placardWidth {
  my $self=shift;
  return $self->{"properties"}->{"placardWidth"};
}

=head2 placardHeight

=cut

sub placardHeight {
  my $self=shift;
  return $self->{"properties"}->{"placardHeight"};
}

=head2 point

Returns a L<GPS::Point> object

=cut

sub point {
  my $self=shift;
  unless (defined($self->{"point"})) {
    #Fortunately all units match between APIs
    $self->{"point"}=GPS::Point->new(lat=>$self->lat,
                                     lon=>$self->lon,
                                     time=>$self->timeStamp,
                                     ehorizontal=>$self->accuracyInMeters);
  }
  return $self->{"point"};
}

=head1 BUGS

Send email to author, geo-perl email list and log on RT.

=head1 SUPPORT

DavisNetworks.com supports all Perl applications including this package.

=head1 AUTHOR

  Michael R. Davis
  CPAN ID: MRDVT
  STOP, LLC
  domain=>michaelrdavis,tld=>com,account=>perl
  http://www.stopllc.com/

=head1 COPYRIGHT

This program is free software licensed under the...

  The General Public License (GPL)
  Version 2, June 1991

The full text of the license can be found in the LICENSE file included with this module.

=head1 SEE ALSO

L<http://www.ruwenzori.net/code/latitude2brightkite/>, L<GPS::Point>

=cut

1;
