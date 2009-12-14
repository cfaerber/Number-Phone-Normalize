use 5.005;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'		=> 'Number::Phone::Normalize',
    'VERSION_FROM'	=> 'Normalize.pm', # finds $VERSION
    'PREREQ_PM'		=> { },
    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM => 'Normalize.pm', # retrieve abstract from module
       AUTHOR     => 'Claus Färber <perl@faerber.muc.de>') : ()),
);
