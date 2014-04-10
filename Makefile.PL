use 5.006;
use strict;
use warnings FATAL => 'all';
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME             => 'Activity::Transactional',
    AUTHOR           => q{James Laver <james.laver@gmail.com>},
    VERSION_FROM     => 'lib/Activity/Transactional.pm',
    ABSTRACT_FROM    => 'lib/Activity/Transactional.pm',
    LICENSE          => 'Artistic_2_0',
    PL_FILES         => {},
    MIN_PERL_VERSION => 5.006,
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => 0,
    },
    BUILD_REQUIRES => {
        'Test::More' => 0,
    },
    PREREQ_PM => {
        'Moose' => 2.1,
        'Try::Tiny' => 0.20,
        'MooseX::Types' => 0.44,
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'Activity-Transactional-*' },
);
