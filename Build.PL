use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Getopt::Euclid',
    license             => 'perl',
    dist_author         => 'Damian Conway <DCONWAY@cpan.org>',
    dist_version_from   => 'lib/Getopt/Euclid.pm',
    requires => {
        'Test::More' => 0,
        'version'    => 0,
        'File::Spec::Functions' => 0,
        'List::Util' => 0,
    },
    add_to_cleanup      => [ 'Getopt-Euclid-*' ],
);

$builder->create_build_script();
