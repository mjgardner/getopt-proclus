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

BEGIN {
    @ARGV = ( "-a 1 2 3", "-b 4 5 6", "Why not", "eat at", "Joes", );
}

use Getopt::Euclid;
use Test::More 'no_plan';

is ref $ARGV{'-a'}, 'ARRAY' => 'Array reference returned for -a';
is $ARGV{'-a'}[0], 1 => 'Got expected value for -a[0]';
is $ARGV{'-a'}[1], 2 => 'Got expected value for -a[1]';
is $ARGV{'-a'}[2], 3 => 'Got expected value for -a[2]';

is ref $ARGV{'-b'}, 'HASH' => 'Hash reference returned for -b';
is $ARGV{'-b'}{first}, 4 => 'Got expected value for -b{first}';
is ref $ARGV{'-b'}{rest}, 'ARRAY' => 'Array reference returned for -b{rest}';
is $ARGV{'-b'}{rest}[0], 5 => 'Got expected value for -b{rest}[0]';
is $ARGV{'-b'}{rest}[1], 6 => 'Got expected value for -b{rest}[1]';

isnt ref $ARGV{'<file>'},
    'ARRAY' => 'Array reference not returned for <file>';
is $ARGV{'<file>'}, 'Why not' => 'Got expected value for <file>';

is ref $ARGV{'<other>'}, 'ARRAY' => 'Array reference returned for <other>';
is $ARGV{'<other>'}[0], 'eat at' => 'Got expected value for <other>[0]';
is $ARGV{'<other>'}[1], 'Joes'   => 'Got expected value for <other>[1]';

__END__

=head1 NAME

orchestrate - Convert a file to Melkor's .orc format

=head1 VERSION

This documentation refers to orchestrate version 1.9.4

=head1 USAGE

    orchestrate  -in source.txt  --out dest.orc  -verbose  -len=24

=head1 OPTIONS

=over

=item  -a <data>...

=for Euclid:
    data.type:   int > 0

=item  -b <first> <rest>...

=for Euclid:
    first.type:   int > 0
    rest.type:    int > 0

=item <file>

=item <other>...

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
