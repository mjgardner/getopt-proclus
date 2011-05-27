#!perl

use Test::More;

use Carp;
use FindBin;
use local::lib "$FindBin::Bin";
use Readonly;
use Test::Moose;

our $CLASS;

BEGIN {
    Readonly our $CLASS => 'Getopt::Proclus::Test::Basic';
    eval "require $CLASS; $CLASS->import(); 1" or croak;
}

my $tests;
for my $attr_name (qw(infile outfile)) {
    has_attribute_ok( $CLASS, $attr_name );
    my $attr = $CLASS->meta->get_attribute($attr_name);

    ok( $attr->is_required, "$attr_name is required" );

    ok( !defined $attr->get_write_method(), "$attr_name read-only" );

    is( $attr->type_constraint->name,
        'MooseX::Types::Path::Class::File',
        "$attr_name isa File"
    );

    $test += 4;
}

done_testing($tests);
