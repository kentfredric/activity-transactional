package Activity::Transactional::Transaction;
$Activity::Transactional::Transaction::VERSION = '0.001000';
our $AUTHORITY = 'cpan:ELPENGUIN'; # AUTHORITY

use Moose;
use Activity::Transactional::Activity;
use Activity::Transactional::Iterator;
use Activity::Transactional::Types;
use Try::Tiny;

with 'Activity::Transactional::Activity';

has _actions => (
  is => 'ro',
  isa => TransactionList,
  traits => ['Array'],
  default => sub { [] },
  required => 0,
  handles => {
    '_push' => 'push',
    '_pop' => 'pop',
  },
}

sub _iterator {
  Activity::Transactional::Iterator(source => $self->_actions);
}

sub commit {
  my $self = shift;
  my $it = $self->_iterator;
  while ($it->can_next) {
    try {
      $it->next->commit;
    } catch {
      warn "Commit failed at index @{[$self->index]}, triggering rollback";
      $self->do_rollback($it);
    }
  }
  1;
}

sub do_rollback {
  my ($self, $it) = @_;
  while($it->can_prev) {
    try {		       
      $it->prev->rollback;
    } catch {
      # This shouldn't happen. Naughty devs
      warn "Rollback failed: $_. Continuing.";
    }
  }
}
sub rollback {
  my $self = shift;
  my $it = $self->_iterator;
  $it->end;
  $self->do_rollback($it);
}  

sub add_activity {
  my ($self,$activity) = @_;
  die("Not an activity") unless is_Activity($activity);
  $self->_push($activity);
}

__PACKAGE__->meta->make_immutable(1);

__END__

=pod

=encoding UTF-8

=head1 NAME

Activity::Transactional::Transaction

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
