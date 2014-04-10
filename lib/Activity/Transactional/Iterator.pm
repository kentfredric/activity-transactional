package Activity::Transactional::Iterator;
$Activity::Transactional::Iterator::VERSION = '0.001000';
# ABSTRACT: A reversible iterator for an ArrayRef

our $AUTHORITY = 'cpan:ELPENGUIN'; # AUTHORITY












use Moose;





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





sub can_next {
  my $self  = shift;
  my $count = $self->count - 1;
  return ( $self->count - 1 <= $self->index );
}





sub can_prev {
  my $self = shift;
  return ( $self->index > 0 );
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
  $self->set_index( $self->last_index );
}





sub can_current {
  shift->index != -1;
}





sub get {
  my $self = shift;
  die("empty") unless $self->can_current;
  $self->source->[ $self->index ];
}





sub set {
  my ( $self, $value ) = @_;
  die("empty") unless $self->can_current;
  $self->source->[ $self->index ] = $value;
}

__PACKAGE__->meta->make_immutable();

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Activity::Transactional::Iterator - A reversible iterator for an ArrayRef

=head1 VERSION

version 0.001000

=head1 SYNOPSIS

  my $iterator => Activity::Transactional::Iterator->new(
     source => \@someArray
  );
  while ( $iterator->can_next ) {
      my $item = $iterator->next;
  }

=head1 METHODS

=head2 C<can_next>

=head2 C<can_prev>

=head2 C<next>

=head2 C<prev>

=head2 C<first>

=head2 C<last_index>

=head2 C<last>

=head2 C<can_current>

=head2 C<get>

=head2 C<set>

=head1 ATTRIBUTES

=head2 C<source>

=head2 C<index>

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
