package Getopt::Proclus;

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

=method init_meta

Moosifies the class and then reads its POD for options to parse from the
command line.

=cut

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

=head1 SEE ALSO

=over

=item L<Getopt::Euclid|Getopt::Euclid>

The inspiration for this distribution

=back
