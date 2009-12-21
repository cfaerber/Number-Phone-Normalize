use 5.005;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'		=> 'Number::Phone::Normalize',
    'VERSION_FROM'	=> 'lib/Number/Phone/Normalize.pm', # finds $VERSION
    'ABSTRACT_FROM'	=> 'lib/Number/Phone/Normalize.pm', # retrieve abstract from module
    'PREREQ_PM'		=> { },
    'AUTHOR'		=> 'Claus Faerber <CFAERBER@cpan.org>',
    'LICENSE'		=> 'perl',
);
