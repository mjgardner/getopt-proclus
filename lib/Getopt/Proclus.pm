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
use Getopt::Proclus::Spec;
use namespace::autoclean;

Moose::Exporter->setup_import_methods( also => 'Moose' );

=method init_meta

Automatically called when you C<use Getopt::Proclus;>.
Moosifies the class and then reads its POD for options to parse from the
command line, returning the modified metaclass.

=cut

sub init_meta {
    shift;
    my %args   = @ARG;
    my $meta   = Moose->init_meta(%args);
    my $parser = Pod::POM->new();
    my $pom    = $parser->parse_file(
        file(
            $INC{ file( split /::/, "$args{for_class}.pm" )->stringify() }
            )->stringify()
    ) or Getopt::Proclus::Error->throw( $parser->error );
    my $spec = Getopt::Proclus::Spec->new( pom => $pom );

    for ( $spec->attribute_names ) {
        $meta->add_attribute( $spec->attribute($ARG) );
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
