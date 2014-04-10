package Activity::Transactional::Types;
$Activity::Transactional::Types::VERSION = '0.001000';
our $AUTHORITY = 'cpan:ELPENGUIN'; # AUTHORITY

use MooseX::Types -declare => [
  qw(Activity Transaction TransactionList)
];

class_type Transaction, {class => 'Activity::Transactional::Transaction'};
role_type Activity, {role => 'Activity::Transactional::Activity'};

__END__

=pod

=encoding UTF-8

=head1 NAME

Activity::Transactional::Types

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
