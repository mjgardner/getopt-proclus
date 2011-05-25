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

use vars qw($INFILE $OUTFILE $LEN $H $W $TIMEOUT);

BEGIN {
    $INFILE  = $0;
    $OUTFILE = $0;
    $LEN     = 42;
    $H       = 2;
    $W       = -10;
    $TIMEOUT = 7;

    @ARGV = (
        "-i   $INFILE", "-out=", $OUTFILE, "-lgth $LEN", "size ${H}x${W}",
        '-no-fudge', '-v', "--timeout $TIMEOUT",
        '-w', 's p a c e s', 7,
    );

    chmod 0644, $0;
}

use Getopt::Euclid qw( :minimal_keys );
use Test::More 'no_plan';

sub got_arg {
    my ( $key, $val ) = @_;
    is $ARGV{$key}, $val, "Got expected value for $key";
}

is keys %ARGV, 19 => 'Right number of args returned';

got_arg 'i'      => $INFILE;
got_arg 'infile' => $INFILE;

got_arg 'l'      => $LEN;
got_arg 'len'    => $LEN;
got_arg 'length' => $LEN;
got_arg 'lgth'   => $LEN;

got_arg 'girth' => 42;

got_arg 'o'       => $OUTFILE;
got_arg 'ofile'   => $OUTFILE;
got_arg 'out'     => $OUTFILE;
got_arg 'outfile' => $OUTFILE;

got_arg
    'v' => 1,
    got_arg
    'verbose' => 1,

    got_arg 'no' => 1;
got_arg 'no_fudge' => 1;

is ref $ARGV{'timeout'}, 'HASH' => 'Hash reference returned for timeout';
is $ARGV{'timeout'}{min}, $TIMEOUT => 'Got expected value for timeout <min>';
is $ARGV{'timeout'}{max}, -1       => 'Got default value for timeout <max>';

is ref $ARGV{size}, 'HASH' => 'Hash reference returned for size';
is $ARGV{size}{h}, $H => 'Got expected value for size <h>';
is $ARGV{size}{w}, $W => 'Got expected value for size <w>';

is $ARGV{w}, 's p a c e s' => 'Handled spaces correctly';

is $ARGV{step}, 7 => 'Handled step size correctly';

__END__

=head1 NAME

orchestrate - Convert a file to Melkor's .orc format

=head1 VERSION

This documentation refers to orchestrate version 1.9.4

=head1 USAGE

    orchestrate  -in source.txt  --out dest.orc  -verbose  -len=24

=head1 REQUIRED ARGUMENTS

=over

=item  -i[nfile]  [=]<file>

Specify input file

=for Euclid:
    file.type:    readable
    file.default: '-'

=item  -o[ut][file]= <out_file>

Specify output file

=for Euclid:
    out_file.type:    writable
    out_file.default: '-'

=back

=head1 OPTIONS

=over

=item  size <h>x<w>

Specify height and width

=item  -l[[en][gth]] <l>

Display length [default: 24 ]

=for Euclid:
    l.type:    int > 0
    l.default: 24

=item  -girth <g>

Display girth [default: 42 ]

=for Euclid:
    g.default: 42

=item -v[erbose]

Print all warnings

=item [-]-timeout [<min>] [<max>]

=for Euclid:
    min.type: int
    max.type: int
    max.default: -1

=item -w <space>

Test something spaced

=item [-]-no[-fudge]

Automaticaly fudge the factors.

=for Euclid:
    false: [-]-no[-fudge]

=item <step>

Step size

=item --version

=item --usage

=item --help

=item --man

Print the usual program information

=back

=begin remainder of documentation here...

=end

=head1 AUTHOR

Damian Conway (damian@conway.org)

=head1 BUGS

There are undoubtedly serious bugs lurking somewhere in this code.
Bug reports and other feedback are most welcome.

=head1 COPYRIGHT

Copyright (c) 2002, Damian Conway. All Rights Reserved.
This module is free software. It may be used, redistributed
and/or modified under the terms of the Perl Artistic License
  (see http://www.perl.com/perl/misc/Artistic.html)
