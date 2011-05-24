
use strict;
use warnings;

BEGIN { require 5.010; }

use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  'ABSTRACT' => 'Executable Uniform Command-Line Interface Descriptions',
  'AUTHOR' => 'Damian Conway <DCONWAY@cpan.org>, Kevin Galinsky <kgalinsky+cpan#gmail.com>, Mark Gardner <mjgardner@cpan.org>',
  'BUILD_REQUIRES' => {
    'File::Find' => '0',
    'File::Temp' => '0',
    'Scalar::Util' => '0',
    'Test::More' => '0.94',
    'perl' => '5.006_001',
    'vars' => '0'
  },
  'CONFIGURE_REQUIRES' => {
    'ExtUtils::MakeMaker' => '6.30'
  },
  'DISTNAME' => 'Getopt-Proclus',
  'EXE_FILES' => [],
  'LICENSE' => 'perl',
  'NAME' => 'Getopt::Proclus',
  'PREREQ_PM' => {
    'Carp' => '0',
    'English' => '0',
    'File::Spec::Functions' => '0',
    'IO::Page' => '0',
    'IO::Pager::Page' => '0',
    'List::Util' => '0',
    'Modern::Perl' => '0',
    'Pod::Text' => '0',
    're' => '0',
    'utf8' => '0'
  },
  'VERSION' => '0.300',
  'test' => {
    'TESTS' => 't/*.t'
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



