package Activity::Transactional::Activity::CodeRef;
$Activity::Transactional::Activity::CodeRef::VERSION = '0.001000';
# ABSTRACT: A simple CodeRef based Activity.

our $AUTHORITY = 'cpan:ELPENGUIN'; # AUTHORITY

use Moose;










with 'Activity::Transactional::Activity';





has commit_code => (
  isa      => 'CodeRef',
  is       => 'ro',
  required => 1,
);





has rollback_code => (
  isa      => 'CodeRef',
  is       => 'ro',
  required => 1,
);





sub commit {
  my ($self) = @_;
  $self->commit_code->();
}





sub rollback {
  my ($self) = @_;
  $self->rollback_code->();
}

__PACKAGE__->meta->make_immutable();

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Activity::Transactional::Activity::CodeRef - A simple CodeRef based Activity.

=head1 VERSION

version 0.001000

=head1 SYNOPSIS

  my $activity = Activity::Transactional::Activity::CodeRef->new(
    commit_code   => sub {},
    rollback_code => sub {},
  );

=head1 METHODS

=head2 C<commit>

=head2 C<rollback>

=head1 ATTRIBUTES

=head2 C<commit_code>

=head2 C<rollback_code>

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
