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

BEGIN {
    @ARGV = qw/ -a foo /;
}

use Test::More 'no_plan';

if ( eval { require Getopt::Euclid and Getopt::Euclid->import(); 1 } ) {
    ok 1 => 'Optional argument not read as required';
}
else {
    ok 0 => 'Optional argument read as required';
}

=head1 REQUIRED

=over

=item -a <a>

=back

=cut

=head1 OPTIONS

=over

=item -b <b>

=back

=cut
