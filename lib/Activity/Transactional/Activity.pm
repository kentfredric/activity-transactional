package Activity::Transactional::Activity;

use Moose::Role;
use strict;
use warnings;

requires 'commit', 'rollback';

1;
__END__