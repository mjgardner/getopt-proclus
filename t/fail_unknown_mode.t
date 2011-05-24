#!perl -T
#
# This file is part of Getopt-Proclus
#
# This software is copyright (c) 2005 by Damian Conway.
#
# This is free software; you can redistribute it and/or modify it under
# the same terms as the Perl 5 programming language system itself.
#
use utf8;
use Modern::Perl;

use Test::More 'no_plan';

BEGIN {
    require 5.006_001 or plan 'skip_all';
    close *STDERR;
    open *STDERR, '>', \my $stderr;
    *CORE::GLOBAL::exit = sub { die $stderr };
}

if ( eval { require Getopt::Euclid and Getopt::Euclid->import(':foo'); 1 } ) {
    ok 0 => 'Unexpectedly succeeded';
}
else {
    like $@, qr/Unknown mode \(':foo'\)/ => 'Failed as expected';
}

if (eval {
        require Getopt::Euclid and Getopt::Euclid->import(':minimal_keys');
        1;
    }
    )
{
    ok 1 => 'Minimal mode accepted';
}
else {
    ok 0 => 'Unexpectedly failed';
}
