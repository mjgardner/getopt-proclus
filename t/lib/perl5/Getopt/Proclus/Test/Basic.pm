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

package Getopt::Proclus::Test::Basic;

# ABSTRACT: Basic Proclus test

use Getopt::Proclus;

1;

=head1 REQUIRED ARGUMENTS

=over

=item  -i[nfile]  [=]<file>

Specify input file

=for Proclus:
    file.is:      ro
    file.isa:     File
    file.default: '-'

=item  -o[ut][file]= <file>

Specify output file

=for Proclus:
    file.is:      ro
    file.isa:     File
    file.default: '-'

=back
