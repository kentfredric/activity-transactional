
use strict;
use warnings;

use Test::More;
use Test::Fatal qw( exception );

use Activity::Transactional::Iterator;

is(
  exception {
    my $activity = Activity::Transactional::Iterator->new( source => [], );
  },
  undef,
  'Constructor does not fail'
);

done_testing;

