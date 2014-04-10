package Activity::Transactional::Transaction;

# AUTHORITY

use Moose;
use Activity::Transactional::Activity;
use Activity::Transactional::Iterator;
use Activity::Transactional::Types qw( TransactionList );
use Try::Tiny;

with 'Activity::Transactional::Activity';

has _actions => (
  is       => 'ro',
  isa      => TransactionList,
  traits   => ['Array'],
  default  => sub { [] },
  required => 0,
  handles  => {
    '_push' => 'push',
    '_pop'  => 'pop',
  },
);

sub _iterator {
  my ( $self, ) = @_;
  Activity::Transactional::Iterator( source => $self->_actions );
}

sub commit {
  my $self = shift;
  my $it   = $self->_iterator;
  while ( $it->can_next ) {
    try {
      $it->next->commit;
    }
    catch {
      warn "Commit failed at index @{[$self->index]}, triggering rollback";
      $self->do_rollback($it);
    };
  }
  1;
}

sub do_rollback {
  my ( $self, $it ) = @_;
  while ( $it->can_prev ) {
    try {
      $it->prev->rollback;
    }
    catch {
      # This shouldn't happen. Naughty devs
      warn "Rollback failed: $_. Continuing.";
    };
  }
}

sub rollback {
  my $self = shift;
  my $it   = $self->_iterator;
  $it->end;
  $self->do_rollback($it);
}

sub add_activity {
  my ( $self, $activity ) = @_;
  die("Not an activity") unless is_Activity($activity);
  $self->_push($activity);
}

__PACKAGE__->meta->make_immutable();
1;
__END__
