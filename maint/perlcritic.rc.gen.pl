#!/usr/bin/env perl
## no critic (Modules::RequireVersionVar)

# FILENAME: bundle_to_ini.pl
# CREATED: 02/06/14 01:48:56 by Kent Fredric (kentnl) <kentfredric@gmail.com>
# ABSTRACT: Write an INI file from a bundle

use 5.008;    #utf8
use strict;
use warnings;
use utf8;

use Carp qw( croak carp );
use Perl::Critic::ProfileCompiler::Util qw( create_bundle );

## no critic (ErrorHandling::RequireUseOfExceptions)
my $bundle = create_bundle('Example::Author::KENTNL');
$bundle->configure;

my @stopwords = (
  qw(
    Laver JJL Perldoc perldoc CodeRef ArrayRef transactional ish
    )
);
for my $wordlist (@stopwords) {
  $bundle->add_or_append_policy_field( 'Documentation::PodSpelling' => ( 'stop_words' => $wordlist ) );
}
$bundle->remove_policy('CodeLayout::ProhibitParensWithBuiltins');
$bundle->remove_policy('CodeLayout::RequireUseUTF8');
$bundle->remove_policy('Compatibility::PerlMinimumVersionAndWhy');
$bundle->remove_policy('ErrorHandling::RequireCarping');
$bundle->remove_policy('ErrorHandling::RequireUseOfExceptions');
$bundle->remove_policy('Modules::RequirePerlVersion');
$bundle->remove_policy('Moose::RequireCleanNamespace');
$bundle->remove_policy('NamingConventions::ProhibitAmbiguousNames');
$bundle->remove_policy('Subroutines::ProhibitBuiltinHomonyms');
$bundle->remove_policy('Subroutines::ProhibitCallsToUndeclaredSubs');
$bundle->remove_policy('Subroutines::ProhibitCallsToUnexportedSubs');
$bundle->remove_policy('Subroutines::RequireFinalReturn');
$bundle->remove_policy('TestingAndDebugging::RequireUseStrict');
$bundle->remove_policy('TestingAndDebugging::RequireUseWarnings');
$bundle->remove_policy('Tics::ProhibitLongLines');
$bundle->remove_policy('ValuesAndExpressions::ProhibitInterpolationOfLiterals');
$bundle->remove_policy('Variables::ProhibitUnusedVarsStricter');

#$bundle->remove_policy('NamingConventions::Capitalization');

my $inf = $bundle->actionlist->get_inflated;

my $config = $inf->apply_config;

{
  open my $rcfile, '>', './perlcritic.rc' or croak 'Cant open perlcritic.rc';
  $rcfile->print( $config->as_ini, "\n" );
  close $rcfile or croak 'Something fubared closing perlcritic.rc';
}
my $deps = $inf->own_deps;
{
  open my $depsfile, '>', './perlcritic.deps' or croak 'Cant open perlcritic.deps';
  for my $key ( sort keys %{$deps} ) {
    $depsfile->printf( "%s~%s\n", $key, $deps->{$key} );
    *STDERR->printf( "%s => %s\n", $key, $deps->{$key} );
  }
  close $depsfile or carp 'Something fubared closing perlcritic.deps';
}

