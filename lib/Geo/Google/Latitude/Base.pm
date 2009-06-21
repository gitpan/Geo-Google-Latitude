package Geo::Google::Latitude::Base;
use strict;
use warnings;

our $VERSION='0.01';

=head1 NAME

Geo::Google::Latitude::Base - Geo::Google::Latitude::Base

=head1 SYNOPSIS

  use base qw{Geo::Google::Latitude::Base};

=head1 DESCRIPTION

=head1 USAGE

=head1 CONSTRUCTOR

=head2 new

  my $obj = Geo::Google::Latitude::Base->new();

=cut

sub new {
  my $this = shift();
  my $class = ref($this) || $this;
  my $self = {};
  bless $self, $class;
  $self->initialize(@_);
  return $self;
}

=head1 METHODS

=head1 initialize

=cut

sub initialize {
  my $self = shift();
  %$self=@_;
}

=head1 BUGS

=head1 SUPPORT

=head1 AUTHOR

    Michael R. Davis
    CPAN ID: MRDVT
    STOP, LLC
    domain=>stopllc,tld=>com,account=>mdavis
    http://www.stopllc.com/

=head1 COPYRIGHT

This program is free software licensed under the...

	The BSD License

The full text of the license can be found in the
LICENSE file included with this module.

=head1 SEE ALSO

=cut

1;
