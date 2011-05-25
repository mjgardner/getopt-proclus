#!perl
#
# This file is part of Getopt-Proclus
#
# This software is copyright (c) 2011 by GSI Commerce.
#
# This is free software; you can redistribute it and/or modify it under
# the same terms as the Perl 5 programming language system itself.
#
use utf8;
use Modern::Perl;

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
