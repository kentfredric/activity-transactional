package Activity::Transactional::Activity;
$Activity::Transactional::Activity::VERSION = '0.001000';
our $AUTHORITY = 'cpan:ELPENGUIN'; # AUTHORITY

use Moose::Role;
use strict;
use warnings;

requires 'commit', 'rollback';

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Activity::Transactional::Activity

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
