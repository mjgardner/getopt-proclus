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

package Getopt::Euclid::HierDemo;

BEGIN {
    $Getopt::Euclid::HierDemo::VERSION = '0.300';
}

# ABSTRACT: Module for hier*.t tests

use Getopt::Euclid;

1;

__END__

=pod

=for :stopwords Damian Conway Kevin Galinsky <kgalinsky+cpan#gmail.com> Mark Gardner cpan
testmatrix url annocpan anno bugtracker rt cpants kwalitee diff irc mailto
metadata placeholders

=head1 NAME

Getopt::Euclid::HierDemo - Module for hier*.t tests

=head1 VERSION

version 0.300

=head1 REQUIRED ARGUMENTS

=over

=item -i[nfile]  [=]<file>

Specify input file

=for Euclid: file.type:    readable
    file.default: '-'

=item -o[ut][file]= <file>

Specify output file

=for Euclid: file.type:    writable
    file.default: '-'

=back

=head1 SUPPORT

=head2 Perldoc

You can find documentation for this module with the perldoc command.

  perldoc Getopt::Euclid

=head2 Websites

The following websites have more information about this module, and may be of help to you. As always,
in addition to those websites please use your favorite search engine to discover more resources.

=over 4

=item *

Search CPAN

The default CPAN search engine, useful to view POD in HTML format.

L<http://search.cpan.org/dist/Getopt-Proclus>

=item *

AnnoCPAN

The AnnoCPAN is a website that allows community annonations of Perl module documentation.

L<http://annocpan.org/dist/Getopt-Proclus>

=item *

CPAN Ratings

The CPAN Ratings is a website that allows community ratings and reviews of Perl modules.

L<http://cpanratings.perl.org/d/Getopt-Proclus>

=item *

CPANTS

The CPANTS is a website that analyzes the Kwalitee ( code metrics ) of a distribution.

L<http://cpants.perl.org/dist/overview/Getopt-Proclus>

=item *

CPAN Testers

The CPAN Testers is a network of smokers who run automated tests on uploaded CPAN distributions.

L<http://www.cpantesters.org/distro/G/Getopt-Proclus>

=item *

CPAN Testers Matrix

The CPAN Testers Matrix is a website that provides a visual way to determine what Perls/platforms PASSed for a distribution.

L<http://matrix.cpantesters.org/?dist=Getopt-Proclus>

=item *

CPAN Testers Dependencies

The CPAN Testers Dependencies is a website that shows a chart of the test results of all dependencies for a distribution.

L<http://deps.cpantesters.org/?module=Getopt::Euclid>

=back

=head2 Bugs / Feature Requests

Please report any bugs or feature requests through the web
interface at L<https://github.com/mjgardner/getopt-proclus/issues>. You will be automatically notified of any
progress on the request by the system.

=head2 Source Code

The code is open to the world, and available for you to hack on. Please feel free to browse it and play
with it, or whatever. If you want to contribute patches, please send me a diff or prod me to pull
from your repository :)

L<https://github.com/mjgardner/getopt-proclus>

  git clone git://github.com/mjgardner/getopt-proclus.git

=head1 AUTHORS

=over 4

=item *

Damian Conway <DCONWAY@cpan.org>

=item *

Kevin Galinsky <kgalinsky+cpan#gmail.com>

=item *

Mark Gardner <mjgardner@cpan.org>

=back

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2005 by Damian Conway.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
