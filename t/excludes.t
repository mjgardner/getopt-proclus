use Test::More 'no_plan';

BEGIN {
    require 5.006_001 or plan 'skip_all';
    close *STDERR;
    open *STDERR, '>', \my $stderr;
    *CORE::GLOBAL::exit = sub { die $stderr };
}

sub got_arg {
    my ($key, $val) = @_;
    is $ARGV{$key}, $val, "Got expected value for $key";
}

sub got_no_arg {
    my ($key) = @_;
    my $res = exists $ARGV{$key} ? 1 : 0;
    is $res, 0, "Got expected absence of $key";
}

# Parse argument specs
use Getopt::Euclid qw(:defer);

chmod 0644, $0;
$INFILE  = $0;
$OUTFILE = $0;
$LEN     = 42;
$H       = 2;
$W       = -10;
$TIMEOUT = 7;

# Validate first set of args (exclusive params)
@argv = (
    "-i   $INFILE",
    "-out=", $OUTFILE,
    "-lgth $LEN",
    "size ${H}x${W}",
    '-v',
    "--timeout $TIMEOUT",
    7,
);

if (eval { Getopt::Euclid->process_args(\@argv); 1 }) {
    ok 0 => 'Unexpectedly succeeded';
} else {
    like $@, qr/excludes/ => 'Failed as expected';
}

# Validate second set of args (other exclusive params)
@argv = (
    "-i   $INFILE",
    "-out=", $OUTFILE,
    "-lgth $LEN",
    '-v',
    "--timeout $TIMEOUT",
    '--with', 's p a c e s',
    7,
);

if (eval { Getopt::Euclid->process_args(\@argv); 1 }) {
    ok 0 => 'Unexpectedly succeeded';
} else {
    like $@, qr/excludes/ => 'Failed as expected';
}


# Validate third set of args (exclusive default values)
@argv = (
    "-i   $INFILE",
    "-out=", $OUTFILE,
    '-v',
    "--timeout $TIMEOUT",
    7,
);
Getopt::Euclid->process_args(\@argv);

got_arg '-length' => 24;
got_no_arg '-h';
got_no_arg '-w';



sub lucky {
    my ($num) = @_;
    return $num == 7;
}



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

=for Euclid:
    h.default: 0.345
    w.default: 1.09

=item  -l[[en][gth]] <l>

Display length [default: 24 ]

=for Euclid:
    l.type:     int > 0
    l.default:  24
    l.excludes: h,w

=item  -girth <g>

Display girth [default: 42 ]

=for Euclid:
    g.default: 42

=item -v[erbose]

Print all warnings

=item --timeout [<min>] [<max>]

=for Euclid:
    min.type: int
    max.type: int
    max.default: -1

=item -w <space> | --with <space>

Test something spaced

=for Euclid:
    space.excludes: step

=item <step>

Step size

=for Euclid:
    step.type: int, lucky(step)
    step.default: 123

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
