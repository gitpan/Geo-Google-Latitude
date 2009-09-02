package Geo::Google::Latitude;
use strict;
use warnings;
use base qw{Geo::Google::Latitude::Base};
use Geo::Google::Latitude::Badge;
use URI qw{};
use LWP::UserAgent qw{};
use JSON::XS qw{};

our $VERSION='0.05';
our $PACKAGE=__PACKAGE__;

=head1 NAME

Geo::Google::Latitude - Retrieves a Google Latitude Public Location Badge

=head1 SYNOPSIS

  use Geo::Google::Latitude;
  my $gl=Geo::Google::Latitude->new;
  my $id="7832225593622256926"; 
  my $badge=$gl->get($id); #isa L<Geo::Google::Latitude::Badge>
  printf "Time: %s, Lat: %s, Lon: %s\n", $badge->point->datetime,
                                         $badge->point->latlon;

=head1 DESCRIPTION

Perl Object Interface to the Google Latitude Public Location Badge.  In order to enable Google Latitude on your mobile device, download Google Maps Mobile and set the permission to share to the public.

=head1 USAGE

  use Geo::Google::Latitude;

=head1 CONSTRUCTOR

=head2 new

Returns a L<Geo::Google::Latitude> blessed object.  If you need to override the API URL you may do so with the optional url parameter.

  my $gl=Geo::Google::Latitude->new;
  my $gl=Geo::Google::Latitude->new(url=>"http://www.google.com/latitude/apps/badge/api");

=head1 METHODS

=head2 get

Fetches the Google Latitude Public Location Badge from google.com and returns a L<Geo::Google::Latitude::Badge> object initialized with the returned JSON encoded data.

  my $badge=$gl->get($id); #isa L<Geo::Google::Latitude::Badge>

=cut

sub get {
  my $self=shift;
  return $self->getList(@_)->[0];
}

=head2 getList

Returns a list of L<Geo::Google::Latitude::Badge> objects with just one HTTP request.

  my @badge=$gl->getList($id1, $id2, $id3); #()
  my $badge=$gl->getList($id1, $id2, $id3); #[]

=cut

sub getList {
  my $self=shift;
  my @id=@_;
  die("Error: Expecting a list of Google Latitude User IDs.") unless @id;
  my $uri=URI->new($self->url);
  $uri->query_form(user=>join(",", @id), type=>"json");
  my $ua=LWP::UserAgent->new;
  $ua->agent("$PACKAGE/$VERSION ");
  $ua->env_proxy;
  my $response=$ua->get($uri);
  my $content=$response->is_success ? $response->decoded_content : undef;
  #my $content=LWP::Simple::get($uri); 
  my $data=JSON::XS->new->pretty->allow_nonref->decode($content);
  die("Error: Expected JSON to parse as HASH") unless ref($data) eq "HASH";
  my @badge=();
  foreach my $feature (@{$data->{"features"}}) {
    push @badge, Geo::Google::Latitude::Badge->new(%$feature);
  }
  return wantarray ? @badge : \@badge;
}

sub url {
  my $self=shift;
  unless (defined($self->{"url"})) {
    $self->{"url"}="http://www.google.com/latitude/apps/badge/api";
  }
  return $self->{"url"};
}

=head1 LIMITATIONS

The getList method has a limit as to the number of badges that can be returned.  But, I have know idea what that upper limit would be.  The length of a URL is typically limited to 2048 bytes and the few IDs that I have seen are 20 characters long. So, we should be able to support more than 90 IDs in one URL accounting for overhead and comma separators.

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
