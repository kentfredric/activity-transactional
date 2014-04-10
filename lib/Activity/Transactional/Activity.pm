package Activity::Transactional::Activity;

# ABSTRACT: Base role for kinds of transactional activities

# AUTHORITY

use Moose::Role;
use strict;
use warnings;

requires 'commit', 'rollback';

1;
__END__
=head1 SYNOPSIS

  package My::Activity;
  use Moose::Role;
  with 'Activity::Transactional::Activity';
  sub commit {
    # Do something that should happen atomically
  }
  sub rollback {
    # If anything fails during the commit, we should clean it up here
  }

=head1 WHY?

It's a neat-ish way of dealing with things as part of a larger transaction.

You can perform cleanup etc. in the case that things go wrong.

=cut