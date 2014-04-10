package Activity::Transactional::Activity;

# ABSTRACT: Base role for kinds of transactional activities

# AUTHORITY

use Moose::Role;
use strict;
use warnings;

requires 'commit', 'rollback';

1;
__END__
