package Number::Phone::Normalize;

use Test::More tests => 5;
use Number::Phone::Normalize;

is(_norm('1-555-FooBar'), '1555366227', 'Normalization');
is(_splitcc('+49-700'), '+49-', 'CC Split');

my $obj = new(__PACKAGE__, own_prefix => '+49-89');
is($obj->{'own_country'}, '49');
is($obj->{'own_area'}, '89');
is($obj->{'area_prefix'}, '0');

