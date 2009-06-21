package Geo::Google::Latitude;
use strict;
use warnings;
use base qw{Geo::Google::Latitude::Base};
use Geo::Google::Latitude::Badge;
use URI qw{};
use LWP::Simple qw{};
use JSON::XS qw{};

our $VERSION='0.02';

=head1 NAME

Geo::Google::Latitude - Retrieves a Google Latitude Public Location Badge

=head1 SYNOPSIS

  use Geo::Google::Latitude;
  my $gl=Geo::Google::Latitude->new;
  my $id=7832225593622256926;
  my $badge=$gl->get($id); #isa Geo::Google::Latitude::Badge

=head1 DESCRIPTION

=head1 USAGE

=head1 METHODS

=head2 get

  my $badge=$gl->get($id); #isa Geo::Google::Latitude::Badge

=cut

sub get {
  my $self=shift;
  my $id=shift
    or die("Error: Expecting Google Latitude User ID as first argument.");
  my $uri=URI->new($self->url);
  $uri->query_form(user=>$id, type=>"json");
  my $content=LWP::Simple::get($uri); 
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

L<http://www.ruwenzori.net/code/latitude2brightkite/>

=cut

1;
