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

package Getopt::Proclus::Spec;

BEGIN {
    $Getopt::Proclus::Spec::VERSION = '0.300';
}

# ABSTRACT: POD options specification

use Modern::Perl;
use English '-no_match_vars';
use Moose;
use MooseX::Has::Sugar;
use Regexp::DefaultFlags;
## no critic (RegularExpressions::RequireDotMatchAnything)
## no critic (RegularExpressions::RequireExtendedFormatting)
## no critic (RegularExpressions::RequireLineBoundaryMatching)
use namespace::autoclean;

has pom => ( ro, required, isa => 'Pod::POM::Node::Pod' );

has _attributes => ( ro, lazy_build,
    isa     => 'HashRef[Moose::Meta::Attribute]',
    traits  => ['Hash'],
    handles => { attribute_names => 'keys', attribute => 'get' },
);

sub _build__attributes {    ## no critic (ProhibitUnusedPrivateSubroutines)
    my $self = shift;

    my %section = map { $ARG->title => $ARG->content } $self->pom->head1();
    my %attribute;
    while ( my ( $title, $content ) = each %section ) {
        next if not $title ~~ [ 'REQUIRED ARGUMENTS', 'OPTIONS' ];
        next if not defined $content or $content->type ne 'over';
        my $required = ( $title eq 'REQUIRED ARGUMENTS' );

        for my $item ( $content->item ) {
            my %attr;
            {
                ## no critic (RegularExpressions::ProhibitUnusedCapture)
                $item->title
                    =~ m{\A (?:--?)? (?<name> \S+) \s+ (?<parameters> .* ) \s* \z};
                %attr = %LAST_PAREN_MATCH;
            }
            $attr{name} =~ s/ \W //gxms;
            $attr{parameters} = [ $attr{parameters} =~ /<\s* (\w+) \s*>/g ];

            my @details = map { $ARG->text }
                grep { $ARG->format =~ /\A Proclus:? \z/ } $item->for;
            for my $detail (@details) {
                my %option;
                {
                    ## no critic (RegularExpressions::ProhibitUnusedCapture)
                    $detail =~ m{
                        (?: (?<parameter> \w+ )[.] )?
                        (?<option> \w+)
                        \s* : \s*
                        (?<value> \S* )
                    };
                    %option = %LAST_PAREN_MATCH;
                }
            }

            if ( @{ $attr{parameters} } < 2 ) {
                $attribute{ $attr{name} } = Moose::Meta::Attribute->new(
                    $attr{name},
                    is       => 'ro',
                    required => $required,
                );
            }
            else {
                for my $sub_attr ( @{ $attr{parameters} } ) {
                    $attribute{"$attr{name}_$sub_attr"}
                        = Moose::Meta::Attribute->new(
                        "$attr{name}_$sub_attr",
                        is       => 'ro',
                        required => $required,
                        );
                }
            }
        }
    }
    return \%attribute;
}

__PACKAGE__->meta->make_immutable();
1;

__END__

=pod

=for :stopwords Mark Gardner Damian Conway Kevin Galinsky <kgalinsky+cpan#gmail.com> GSI
Commerce cpan testmatrix url annocpan anno bugtracker rt cpants kwalitee
diff irc mailto metadata placeholders

=encoding utf8

=head1 NAME

Getopt::Proclus::Spec - POD options specification

=head1 VERSION

version 0.300

=head1 SYNOPSIS

    use Getopt::Proclus::Spec;
    use Pod::POM;

    my $spec = Getopt::Proclus::Spec->new(
        pom => Pod::POM->new->parse_text($pod_text) );
    print "$_\n" for $spec->attribute_names;

=head1 DESCRIPTION

This module parses a command line option specification described in
L<POD|perlpod> and turns it into L<Moose attribute|Moose::Meta::Attribute>s.

=head1 ATTRIBUTES

=head2 pom

Required attribute containing the L<Pod::POM::Node::Pod|Pod::POM::Node::Pod>
results of parsing the class's POD.

=head1 METHODS

=head2 attribute_names

Returns a list of attribute names defined in the POD.

=head2 attribute

Given an attribute name, returns the
L<Moose::Meta::Attribute|Moose::Meta::Attribute> representation parsed from the
class's POD.

=head1 SEE ALSO

=over

=item L<Getopt::Proclus|Getopt::Proclus>

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
