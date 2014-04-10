package Activity::Transactional::Activity::CodeRef;

# ABSTRACT: A simple CodeRef based Activity.

# AUTHORITY

use Moose;

=head1 SYNOPSIS

  my $activity = Activity::Transactional::Activity::CodeRef->new(
    commit_code   => sub {},
    rollback_code => sub {},
  );

=cut

with 'Activity::Transactional::Activity';

=attr C<commit_code>

=cut

has commit_code => (
  isa      => 'CodeRef',
  is       => 'ro',
  required => 1,
);

=attr C<rollback_code>

=cut

has rollback_code => (
  isa      => 'CodeRef',
  is       => 'ro',
  required => 1,
);

=method C<commit>

=cut

sub commit {
  my ($self) = @_;
  $self->commit_code->();
}

=method C<rollback>

=cut

sub rollback {
  my ($self) = @_;
  $self->rollback_code->();
}

__PACKAGE__->meta->make_immutable();

1;
__END__
