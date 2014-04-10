package Activity::Transactional::Activity;

# AUTHORITY

use Moose::Role;
use strict;
use warnings;

requires 'commit', 'rollback';

1;
__END__
