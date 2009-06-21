package Geo::Google::Latitude::Badge;
use strict;
use warnings;
use base qw{Geo::Google::Latitude::Base};
use GPS::Point;

our $VERSION='0.02';

=head1 NAME

Geo::Google::Latitude::Badge - Retrieves a Google Public Location Badge

=head1 SYNOPSIS

  use Geo::Google::Latitude;
  my $gl=Geo::Google::Latitude->new;
  my $id=7832225593622256926;
  my $badge=$gl->get($id); #ISA Geo::Google::Latitude::Badge

=head1 DESCRIPTION

=head1 USAGE

=head1 METHODS

=head2 point

Returns a GPS::Point object

=cut

sub point {
  my $self=shift;
  unless (defined($self->{"point"})) {
    #Fortunately all units match between APIs
    my $lat=$self->{"features"}->[0]->{"geometry"}->{"coordinates"}->[0];
    my $lon=$self->{"features"}->[0]->{"geometry"}->{"coordinates"}->[1];
    my $time=$self->{"features"}->[0]->{"properties"}->{"timeStamp"};
    my $eh=$self->{"features"}->[0]->{"properties"}->{"accuracyInMeters"};
    $self->{"point"}=GPS::Point->new(lat=>$lat, time=>$time,
                                     lon=>$lon, ehorizontal=>$eh);
  }
  return $self->{"point"};
}

=head1 BUGS

Log and send to Geo Perl.

=head1 SUPPORT

Try Geo Perl.

=head1 AUTHOR

    Michael R. Davis
    CPAN ID: MRDVT
    STOP, LLC
    domain=>michaelrdavis,tld=>com,account=>perl
    http://www.stopllc.com/

=head1 COPYRIGHT

This program is free software licensed under the...

	The BSD License

The full text of the license can be found in the
LICENSE file included with this module.

=head1 SEE ALSO

L<http://www.ruwenzori.net/code/latitude2brightkite/>

=cut

1;
