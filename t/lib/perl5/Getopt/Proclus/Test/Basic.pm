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
