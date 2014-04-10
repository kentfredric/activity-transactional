package Activity::Transactional::Iterator;

# AUTHORITY

use Moose;

has source => (
  isa => 'ArrayRef[Any]',
  is => 'ro',
  required => 1,
  traits => ['Array'],
  handles => {
    'count' => 'count',
    'can_first' => 'count',
    'can_last' => 'count',
  }
);

has index => (
  isa => 'Num',
  is => 'ro',
  default => -1,
  required => 0,
  traits => ['Number'],
  handles => {
   'set_index' => 'set',
   'inc_index' => [ 'add', 1 ],
   'dec_index' => [ 'sub', 1 ],
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
  return $self->count - 1;
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

__PACKAGE__->meta->make_immutable();

1;
__END__
