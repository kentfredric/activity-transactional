package Activity::Transactional::Iterator;

# ABSTRACT: A reversible iterator for an ArrayRef

# AUTHORITY

=head1 SYNOPSIS

  my $iterator => Activity::Transactional::Iterator->new(
     source => \@someArray
  );
  while ( $iterator->can_next ) {
      my $item = $iterator->next;
  }

=cut

use Moose;

=attr C<source>

=cut

has source => (
  isa      => 'ArrayRef[Any]',
  is       => 'ro',
  required => 1,
  traits   => ['Array'],
  handles  => {
    'count'     => 'count',
    'can_first' => 'count',
    'can_last'  => 'count',
  },
);

=attr C<index>

=cut

has index => (
  isa      => 'Num',
  is       => 'ro',
  default  => -1,
  required => 0,
  traits   => ['Number'],
  handles  => {
    'set_index' => 'set',
    'inc_index' => [ 'add', 1 ],
    'dec_index' => [ 'sub', 1 ],
  },
);

=method C<can_next>

=cut

sub can_next {
  my $self  = shift;
  my $count = $self->count - 1;
  return ( $self->count - 1 <= $self->index );
}

=method C<can_prev>

=cut

sub can_prev {
  my $self = shift;
  return ( $self->index > 0 );
}

=method C<next>

=cut

sub next {
  my $self = shift;
  die("nomore") unless $self->can_next;
  $self->inc_index;
  $self->get;
}

=method C<prev>

=cut

sub prev {
  my $self = shift;
  die("nomore") unless $self->can_prev;
  $self->dec_index;
  $self->get;
}

=method C<first>

=cut

sub first {
  my $self = shift;
  die("empty") unless $self->can_first;
  $self->set_index(0);
}

=method C<last_index>

=cut

sub last_index {
  my $self = shift;
  die("empty") unless $self->can_last;
  return $self->count - 1;
}

=method C<last>

=cut

sub last {
  my $self = shift;
  $self->set_index( $self->last_index );
}

=method C<can_current>

=cut

sub can_current {
  shift->index != -1;
}

=method C<get>

=cut

sub get {
  my $self = shift;
  die("empty") unless $self->can_current;
  $self->source->[ $self->index ];
}

=method C<set>

=cut

sub set {
  my ( $self, $value ) = @_;
  die("empty") unless $self->can_current;
  $self->source->[ $self->index ] = $value;
}

__PACKAGE__->meta->make_immutable();

1;
__END__
