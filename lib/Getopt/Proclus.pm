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

package Getopt::Proclus;

BEGIN {
    $Getopt::Proclus::VERSION = '0.300';
}

# ABSTRACT: POD-Readable Options for Command-Line Uniform Syntax

use Modern::Perl;
use Carp;
use English '-no_match_vars';
use Moose ();
use Moose::Error::Default;
use Moose::Exporter;
use Path::Class;
use Pod::POM;
use Regexp::DefaultFlags;
## no critic (RegularExpressions::RequireDotMatchAnything)
## no critic (RegularExpressions::RequireExtendedFormatting)
## no critic (RegularExpressions::RequireLineBoundaryMatching)
use Getopt::Proclus::Error;
use namespace::autoclean;

Moose::Exporter->setup_import_methods( also => 'Moose' );

sub init_meta {
    shift;
    my %args = @ARG;
    my $meta = Moose->init_meta(%args);

    my $parser = Pod::POM->new();
    my $pom    = $parser->parse_file(
        file(
            $INC{ file( split /::/, "$args{for_class}.pm" )->stringify() }
            )->stringify()
    ) or Getopt::Proclus::Error->throw( $parser->error() );

    my @required_items = map { $ARG->item } map { $ARG->over }
        grep { $ARG->title eq 'REQUIRED ARGUMENTS' } $pom->head1();

    for my $item (@required_items) {
        my %attr;
        {
            ## no critic (RegularExpressions::ProhibitUnusedCapture)
            $item->title
                =~ m{\A (?:--?)? (?<name> \S+) \s+ (?<parameters> .* ) \s* \z};
            %attr = %LAST_PAREN_MATCH;
        }
        $attr{name} =~ s/ \W //gxms;
        $attr{parameters} = [ $attr{parameters} =~ /<\s* (\w+) \s*>/g ];

        if ( @{ $attr{parameters} } < 2 ) {
            $meta->add_attribute(
                $attr{name},
                accessor => $attr{name},
                required => 1,
            );
        }
        else {
            for my $sub_attr ( @{ $attr{parameters} } ) {
                $meta->add_attribute(
                    "$attr{name}_$sub_attr",
                    accessor => "$attr{name}_$sub_attr",
                    required => 1,
                );
            }
        }
    }

    return $meta;
}

1;

__END__

=pod

=for :stopwords Mark Gardner Damian Conway Kevin Galinsky <kgalinsky+cpan#gmail.com> GSI
Commerce cpan testmatrix url annocpan anno bugtracker rt cpants kwalitee
diff irc mailto metadata placeholders

=encoding utf8

=head1 NAME

Getopt::Proclus - POD-Readable Options for Command-Line Uniform Syntax

=head1 VERSION

version 0.300

=head1 SYNOPSIS

    package My::Command;
    use Getopt::Proclus;

    sub read_file {
        my $self = shift;
        say 'reading ', $self->infile->stringify();
        return;
    }

    1;

    =head1 REQUIRED ARGUMENTS

    =over

    =item -i[nfile] [=]<file>

    Specify input file

    =for Proclus:
        file.is:  ro
        file.isa: File

=head1 DESCRIPTION

This module enables you to specify command line options for setting attributes
in a L<Moose|Moose> class by writing them as L<POD|perlpod> within your class.
You can then be assured that your documentation and options available are
always in sync.

=head1 METHODS

=head2 init_meta

Moosifies the class and then reads its POD for options to parse from the
command line.

=head1 SEE ALSO

=over

=item L<Getopt::Euclid|Getopt::Euclid>

The inspiration for this distribution

=back

=head1 SUPPORT

=head2 Perldoc

You can find documentation for this module with the perldoc command.

  perldoc Getopt::Proclus

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

L<http://deps.cpantesters.org/?module=Getopt::Proclus>

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

Mark Gardner <mjgardner@cpan.org>

=item *

Damian Conway <DCONWAY@cpan.org>

=item *

Kevin Galinsky <kgalinsky+cpan#gmail.com>

=back

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by GSI Commerce.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
