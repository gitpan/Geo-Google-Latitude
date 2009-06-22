package Geo::Google::Latitude;
use strict;
use warnings;
use base qw{Geo::Google::Latitude::Base};
use Geo::Google::Latitude::Badge;
use URI qw{};
#use LWP::Simple qw{};
use LWP::UserAgent qw{};
use JSON::XS qw{};

our $VERSION='0.04';
our $PACKAGE=__PACKAGE__;

=head1 NAME

Geo::Google::Latitude - Retrieves a Google Latitude Public Location Badge

=head1 SYNOPSIS

  use Geo::Google::Latitude;
  my $gl=Geo::Google::Latitude->new;
  my $id=7832225593622256926;
  my $badge=$gl->get($id); #isa L<Geo::Google::Latitude::Badge>

=head1 DESCRIPTION

Perl Object Interface to the Google Latitude Public Location Badge.  In order to enable Google Latitude down load Google Maps on your mobile device and set the permission to share to the public.

=head1 USAGE

  use Geo::Google::Latitude;
  my $gl=Geo::Google::Latitude->new(
            url=>"http://www.google.com/latitude/apps/badge/api");

=head1 CONSTRUCTOR

=head2 new

Returns a L<Geo::Google::Latitude> blessed object.  If you need to over ride the API URL you may do so with the optional url parameter.

=head1 METHODS

=head2 get

Fetches the Google Latitude Public Location Badge from google.com and returns a L<Geo::Google::Latitude::Badge> object initialized with the JSON encoded data.

  my $badge=$gl->get($id); #isa L<Geo::Google::Latitude::Badge>

Note: Even though the JSON Google API supports multiple users by using a comma-separated list of user identifiers.  This API was written to work for one user identifier at a time.

=cut

sub get {
  my $self=shift;
  my $id=shift
    or die("Error: Expecting Google Latitude User ID as argument.");
  my $uri=URI->new($self->url);
  $uri->query_form(user=>$id, type=>"json");
  my $ua=LWP::UserAgent->new;
  $ua->agent("$PACKAGE/$VERSION ");
  $ua->env_proxy;
  my $response=$ua->get($uri);
  my $content=$response->is_success ? $response->decoded_content : undef;
  #my $content=LWP::Simple::get($uri); 
  my $data=JSON::XS->new->pretty->allow_nonref->decode($content);
  die("Error: Expected JSON to parse as HASH") unless ref($data) eq "HASH";
  return Geo::Google::Latitude::Badge->new(%$data);
}

sub url {
  my $self=shift;
  unless (defined($self->{"url"})) {
    $self->{"url"}="http://www.google.com/latitude/apps/badge/api";
  }
  return $self->{"url"};
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

L<http://www.google.com/latitude/apps/badge>, L<http://www.ruwenzori.net/code/latitude2brightkite/>, L<LWP::Simple>, L<URI>, L<JSON::XS>, L<GPS::Point>, L<Geo::Google::Latitude::Badge>

=cut

1;
