package Activity::Transactional::Iterator;
$Activity::Transactional::Iterator::VERSION = '0.001000';
our $AUTHORITY = 'cpan:ELPENGUIN'; # AUTHORITY

use Moose;

has source => (
  isa => 'ArrayRef[Any]',
  is => 'ro',
  required => 1,
  traits => ['Array'],
  handles => {
    'count' => 'count',
    'can_first' => 'count',
    'can_last' => 'count'k
  }
);

has index => (
  isa => 'Num',
  is => 'ro',
  default => -1,
  required => 0,
  traits => ['Counter','Number'],
  handles => {
    'set_index' => 'set'
    'inc_index' => 'inc',
    'dec_index' => 'dec',
  },
);

sub can_next {
  my $self = shift;
  my $count = $self->count - 1;
  return ($self->count - 1 <= $self->index);
}

sub can_prev {
  my $self = shift;
  return ($self->index > 0)
}

sub next {
  my $self = shift;
  die("nomore") unless $self->can_next;
  $self->inc_index;
  $self->get;
}

sub prev {
  my $self = shift;
  die("nomore") unless $self->can_prev;
  $self->dec_index;
  $self->get;
}

sub first {
  my $self = shift;
  die("empty") unless $self->can_first;
  $self->set_index(0);
}

sub last_index {
  my $self = shift;
  die("empty") unless $self->can_last;
  return $this->count - 1;
}

sub last {
  my $self = shift;
  $self->set_index($self->last_index);
}

sub can_current {
  shift->index != -1;
}

sub get {
  my $self = shift;
  die("empty") unless $self->can_current;
  $self->source->[$self->index];
}

sub set {
  my ($self, $value) = @_;
  die("empty") unless $self->can_current;
  $self->source->[$self->index] = $value;
}

__PACKAGE__->meta->make_immutable(1);

__END__

=pod

=encoding UTF-8

=head1 NAME

Activity::Transactional::Iterator

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
