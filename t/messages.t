BEGIN {
    $INFILE  = $0;
    $OUTFILE = $0;

    @ARGV = (
        "-i   $INFILE",
        "-out=", $OUTFILE,
    );

    chmod 0644, $0;
}

use Getopt::Euclid qw( :minimal_keys );
use Test::More 'no_plan';


my $man =
q{=head1 NAME

 messages.t - Convert a file to Melkor's .orc format

=head1 SYNOPSIS

   my $var = 'asdf';

=head1 VERSION

 This document refers to messages.t version 1.9.4 

=head1 USAGE

     messages.t -o= <out_file> -i <file> [options] 

=head1 REQUIRED ARGUMENTS

=over

=item -o[ut][file]= <out_file>

Specify output file

=item -i[nfile]  [=]<file>

Specify input file

=back



=head1 OPTIONS

=over

=item size <h>x<w>

Specify height and width

=item <step>

Step size

=item [-]-timeout [<min>] [<max>]

=item -l[[en][gth]] <l>

Display length [default: 24 ]

=item --usage

=item -v[erbose]

Print all warnings

=item -w <space>

Test something spaced

=item --version

=item -girth <g>

Display girth [default: 42 ]

=item [-]-no[-fudge]

Automaticaly fudge the factors.

=item --man

Print the usual program information

=item --help

=back



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
};


my $help =
q{=head1 Usage:

       messages.t -o= <out_file> -i <file> [options]
       messages.t --help
       messages.t --version

=head1 Required arguments:

=over

=item -o[ut][file]= <out_file>

Specify output file

=item -i[nfile]  [=]<file>

Specify input file

=back



=head1 Options:

=over

=item size <h>x<w>

Specify height and width

=item <step>

Step size

=item [-]-timeout [<min>] [<max>]

=item -l[[en][gth]] <l>

Display length [default: 24 ]

=item --usage

=item -v[erbose]

Print all warnings

=item -w <space>

Test something spaced

=item --version

=item -girth <g>

Display girth [default: 42 ]

=item [-]-no[-fudge]

Automaticaly fudge the factors.

=item --man

Print the usual program information

=item --help

=back



};

my $usage =
'Usage:
       messages.t -o= <out_file> -i <file> [options]
       messages.t --help
       messages.t --version
';

my $version =
'This is messages.t version 1.9.4

Copyright (c) 2002, Damian Conway. All Rights Reserved.
This module is free software. It may be used, redistributed
and/or modified under the terms of the Perl Artistic License
  (see http://www.perl.com/perl/misc/Artistic.html)
';


my $man_test = Getopt::Euclid->man();
is $man_test, $man     => 'Correct man message';

my $help_test = Getopt::Euclid->help();
is $help_test, $help    => 'Correct help message';

my $usage_test = Getopt::Euclid->usage();
is $usage_test, $usage   => 'Correct usage message';

my $version_test = Getopt::Euclid->version();
is $version_test, $version => 'Correct version message';


__END__

=head1 NAME

orchestrate - Convert a file to Melkor's .orc format

=head1 SYNOPSIS

   my $var = 'asdf';

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
