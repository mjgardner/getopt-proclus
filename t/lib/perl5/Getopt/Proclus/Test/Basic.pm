package Getopt::Proclus::Test::Basic;

# ABSTRACT: Basic Proclus test

use Getopt::Proclus;
use MooseX::Has::Sugar;
use MooseX::Types::Moose 'Bool';
use MooseX::Types::Path::Class 'File';

=head1 REQUIRED ARGUMENTS

=over

=item  -i[nfile]  [=]<file>

Specify input file

=cut

has '+infile' => ( isa => File, default => '<-' );

=item  -o[ut][file]= <file>

Specify output file

=cut

has '+outfile' => ( isa => File, default => '>-' );

=back

=head1 OPTIONS

=over

=item -v[erbose]

Report progress

=cut

1;
