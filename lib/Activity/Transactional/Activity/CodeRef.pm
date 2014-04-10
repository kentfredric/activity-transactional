package Activity::Transactional::Activity::CodeRef;

# AUTHORITY

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

__PACKAGE__->meta->make_immutable();

1;
__END__
