#!perl -T
#
# This file is part of Getopt-Proclus
#
# This software is copyright (c) 2005 by Damian Conway.
#
# This is free software; you can redistribute it and/or modify it under
# the same terms as the Perl 5 programming language system itself.
#
use 5.008;
use strict;
use warnings;
use utf8;

use Test::More;
eval "use Test::Pod::Coverage 1.04 tests=>1";
plan skip_all => "Test::Pod::Coverage 1.04 required for testing POD coverage"
    if $@;
pod_coverage_ok( "Getopt::Euclid", "Getopt::Euclid's POD is covered" );
