package Activity::Transactional::Types;

# ABSTRACT: Types for Activity::Transactional

# AUTHORITY

use strict;
use warnings;

use MooseX::Types -declare => [qw(Activity Transaction TransactionList)];
use MooseX::Types::Moose qw( ArrayRef );

class_type Transaction, { class => 'Activity::Transactional::Transaction' };
role_type Activity,     { role  => 'Activity::Transactional::Activity' };
subtype TransactionList, as ArrayRef [Transaction];

1;
