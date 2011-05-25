package Getopt::Proclus::Spec;

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

=attr pom

Required attribute containing the L<Pod::POM::Node::Pod|Pod::POM::Node::Pod>
results of parsing the class's POD.

=cut

has pom => ( ro, required, isa => 'Pod::POM::Node::Pod' );

=method attribute_names

Returns a list of attribute names defined in the POD.

=method attribute

Given an attribute name, returns the
L<Moose::Meta::Attribute|Moose::Meta::Attribute> representation parsed from the
class's POD.

=cut

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

=head1 SYNOPSIS

    use Getopt::Proclus::Spec;
    use Pod::POM;

    my $spec = Getopt::Proclus::Spec->new(
        pom => Pod::POM->new->parse_text($pod_text) );
    print "$_\n" for $spec->attribute_names;

=head1 DESCRIPTION

This module parses a command line option specification described in
L<POD|perlpod> and turns it into L<Moose attribute|Moose::Meta::Attribute>s.

=head1 SEE ALSO

=over

=item L<Getopt::Proclus|Getopt::Proclus>

=back
