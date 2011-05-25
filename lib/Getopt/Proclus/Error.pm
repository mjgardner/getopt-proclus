package Getopt::Proclus::Error;

# ABSTRACT: Error thrown by Getopt::Proclus

use Moose;
use namespace::autoclean;
extends 'Throwable::Error';

1;

=head1 SYNOPSIS

    use Getopt::Proclus::Error;

    Getopt::Proclus::Error->throw('something bad happened');

=head1 DESCRIPTION

This is a very basic subclass of L<Throwable::Error|Throwable::Error>.

=head1 SEE ALSO

=over

=item L<Throwable::Error|Throwable::Error>

=back
