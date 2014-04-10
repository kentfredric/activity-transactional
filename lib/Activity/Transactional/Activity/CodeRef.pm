package Activity::Transactional::Activity::CodeRef;
$Activity::Transactional::Activity::CodeRef::VERSION = '0.001000';
our $AUTHORITY = 'cpan:ELPENGUIN'; # AUTHORITY

use Moose;

with 'Activity::Transactional::Activity';

has commit_code => (
  isa => 'CODE',
  is => 'ro',
  required => 1,
);

has rollback_code => (
  isa => 'CODE',
  is => 'ro',
  required => 1,
);

sub commit {
  my ( $self ) = @_;
  $self->commit_code->()
}

sub rollback_code {
  my ( $self ) = @_;
  $self->rollback_code->()
}

__PACKAGE__->meta->make_immutable(1);

__END__

=pod

=encoding UTF-8

=head1 NAME

Activity::Transactional::Activity::CodeRef

=head1 VERSION

version 0.001000

=head1 AUTHORS

=over 4

=item *

James Laver <james.laver@gmail.com>

=item *

Kent Fredric <kentnl@cpan.org>

=back

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2014 by James Laver.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut
