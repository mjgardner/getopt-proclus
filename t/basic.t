#!perl

use Test::More tests => 2;

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

has_attribute_ok( $CLASS, 'infile' );
has_attribute_ok( $CLASS, 'outfile' );
