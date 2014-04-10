package Activity::Transactional::Activity::CodeRef;

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
  $self->commit_code->()
}

sub rollback_code {
  $self->rollback_code->()
}

__PACKAGE__->meta->make_immutable(1);
__END__
