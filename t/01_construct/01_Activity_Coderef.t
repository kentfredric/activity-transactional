
use strict;
use warnings;

use Test::More;
use Test::Fatal qw( exception );

# FILENAME: 01_Activity_Coderef.t
# CREATED: 04/11/14 08:15:03 by Kent Fredric (kentnl) <kentfredric@gmail.com>
# ABSTRACT: Test attribute constructor params are valid

use Activity::Transactional::Activity::CodeRef;

is(
  exception {
    my $activity = Activity::Transactional::Activity::CodeRef->new(
      commit_code   => sub { },
      rollback_code => sub { },
    );
  },
  undef,
  'Constructor does not fail'
);

done_testing;

