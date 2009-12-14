package Number::Phone::Normalize;
# $Id: none yet $

use strict;
use warnings;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw(phone_intl phone_local);

our $VERSION = '0.00_20051127';

my $noarea =	{ area_length => 0, intl_prefix => '00' }; 
my $noarea011 = { area_length => 0, intl_prefix => '011' }; 
my $var = 	{ area_prefix => '0', intl_prefix => '00' } ;
my $fix1 = 	{ area_length => 1, %{$var} };
my $fix2 = 	{ area_length => 2, %{$var} };
my $fix3 = 	{ area_length => 3, %{$var} }; 
my $var12 = 	{ area_length_min => 1, area_length_max => 2, %{$var} };
my $var13 = 	{ area_length_min => 1, area_length_max => 3, %{$var} }; 
my $var14 = 	{ area_length_min => 1, area_length_max => 4, %{$var} }; 
my $var23 = 	{ area_length_min => 1, area_length_max => 2, %{$var} }; 
my $var24 = 	{ area_length_min => 2, area_length_max => 4, %{$var} }; 
my $var25 = 	{ area_length_min => 2, area_length_max => 4, %{$var} }; 
my $cis = 	{ area_prefix => '8', intl_prefix => '8W10' };

my %country_info = (
    '1'		=> { area_length => 3, area_prefix_alt => ['1'], intl_prefix => '11' }, # NANP
    '20'	=> $var,	# Egypt
    '212'	=> $var12,	# Morocco
    '213'	=> $fix2,  	# Algeria
    '216'	=> $noarea,	# Tunisia
    '218'	=> $var,	# Libya
    '220'	=> $noarea,	# Gambia
    '221'	=> $noarea,	# Senegal
    '222'	=> $noarea,	# Mauritania
    '223'	=> $noarea,	# Mali
    '224'	=> $noarea,	# Guinea
    '225'	=> $noarea,	# Cote d'Ivore
    '226'	=> $noarea,	# Burkia Faso
    '227'	=> $noarea,	# Niger
    '228'	=> $noarea,	# Togolese Rep.
    '229'	=> $noarea,	# Benin
    '230'	=> $noarea,	# Mauritius
    '231'	=> $noarea,	# Libaria
    '232'	=> $fix2,	# Sierra Leone
    '233'	=> $var,	# Ghana
    '234'	=> { area_length_min => 1, area_length_max => 2, area_prefix => '0', intl_prefix => '009' }, # Nigeria
    '236'	=> { area_length => 0, intl_prefix => '15' }, # Chad
    '236'	=> { area_length => 0, intl_prefix => '19' }, # CAF
    '237'	=> $noarea,	# Cameroon
    '238'	=> { area_length => 0, intl_prefix => '0' }, # Cape Verde
    '239'	=> $noarea,	# Sao Tome & P.
    '240'	=> $noarea,	# Equatorial Guinea
    '241'	=> $noarea,	# Gabonese Republic
    '242'	=> $noarea,	# Congo, Republic of
    '243'	=> $fix1,	# Congo, Democratic Republic of
    '244'	=> $fix1,	# Angola
    '245'	=> $noarea,	# Guinea-Bissau
    '246'	=> $noarea,	# Diego Garcia
    '247'	=> $noarea,	# Ascension
    '248'	=> $noarea,	# Seychelles
    '249'	=> $var23,	# Sudan
    '250'	=> $noarea,	# Rwanda
    '251'	=> $fix1,	# Ethopia
    '252'	=> { intl_prefix => '00' }, # Somalia
    '253'	=> $noarea,	# Djibouti
    '254'	=> { area_prefix => '0', intl_prefix => '000' }, # Kenya
    '255' 	=> { area_length_min => 2, area_length_max => 3, area_prefix => '0', intl_prefix => '000' }, # Tansania
    '256'	=> { area_length_min => 2, area_length_max => 5, area_prefix => '0', intl_prefix => '000' }, # Uganda
    '257'	=> { },		# Burundi
    '258'	=> $var12,	# Mozambique
    '260'	=> $var12,	# Zambia
    '261',	=> $noarea,	# Madagascar
    '262'	=> $noarea,	# Reunion
    '263'	=> $var12,	# Zimbabwe
    '264'	=> $var24,	# Namibia
    '265'	=> $noarea,	# Malawi
    '266'	=> $noarea,	# Lesotho
    '267'	=> $noarea,	# Botswana
    '268'	=> $noarea,	# Swaziland
    '269'	=> $noarea,	# Comoros & MAyotte
    '27'	=> { area_length_min => 2, area_length_max => 5, area_prefix => '0', intl_prefix => '09', intl_prefix_alt => ['00'] }, # South Africa
    '290'	=> $noarea,	# St. Helena
    '291'	=> $fix1,	# Eritrea
    '297'	=> $fix1,	# Aruba
    '298'	=> $noarea,	# Faroe Is.
    '299'	=> { area_length => 0, intl_prefix => '009' }, # Greenland
    '30'	=> $noarea,	# Greece
    '31'	=> $var23,	# Netherlands
    '32'	=> $var,	# Belgium
    '33'	=> $noarea,	# France
    '34'	=> $noarea,	# Spain
    '350'	=> $noarea,	# Gibraltar
    '351'	=> $var12,	# Portugal
    '352'	=> $noarea,	# Luxembourg
    '353'	=> $var,	# Ireland
    '354'	=> $noarea,	# Iceland
    '355'	=> $var, 	# Albania
    '356'	=> $noarea,	# Malta
    '357'	=> $noarea,	# Cyrpus 
    '358'	=> $var,	# Finland
    '359'	=> $var,	# Bulgaria
    '36'	=> { area_prefix => '06', intl_prefix => '00' }, # Hungary
    '370'	=> { area_prefix => '8', intl_prefix => '00' }, # Lithuania
    '371'	=> $noarea,	# Lativa
    '372'	=> $noarea,	# Estonia
    '373'	=> $var23,	# Moldova
    '374'	=> $var,	# Armenia
    '375'	=> $cis,	# Belarus
    '376'	=> $noarea,	# Andorra
    '377'	=> $noarea,	# Monaco
    '378'	=> $noarea,	# San Marino
    '379'	=> $noarea,	# Vatican (?)
    '380'	=> { area_length_min => 2, area_length_max => 3, %{$cis} }, # Ukraine
    '381'	=> { intl_prefix_alt => ['99'], %{$var23} }, # Serbia and Montenegro
    '385'	=> $var,	# Croatia
    '386'	=> $fix1,	# Slovenia
    '387'	=> $fix2,	# Bosnia & H.
    '389',	=> $var12,	# Macedonia
    '39'	=> $noarea,	# Italy
    '40'	=> $var23,	# Romania
    '41'	=> $var12,	# Switzerland
    '420'	=> $noarea,	# Czech Rep.
    '421'	=> $var12,	# Slovakia
    '423'	=> $noarea,	# Liechtenstein
    '43'	=> $var,	# Austria
    '44'	=> { area_length_min => 2, area_length_max => 6, %{$var} }, # UK
    '45'	=> $noarea,	# Denmark
    '46'	=> $var13,	# Sweden
    '47'	=> $noarea,	# Norway
    '48'	=> $var14,	# Poland
    '49'	=> $var,	# Germany
    '500'	=> $noarea,	# Falkland Is.
    '501'	=> $noarea,	# Belize
    '502'	=> $noarea,	# Guatemala
    '503'	=> $noarea,	# El Salvador
    '504'	=> $noarea,	# Hondouras
    '505'	=> $noarea,	# Nicaragua
    '506'	=> $noarea,	# Costa Rica
    '507'	=> $noarea, 	# Panama
    '508'	=> $noarea,	# St. Pierre & M.
    '509'	=> $noarea,	# Haiti
    '51'	=> $var12,	# Peru
    '52'	=> { area_length_min => 1, area_length_max => 3, area_prefix_alt => ['01','02'], intl_prefix_alt => ['00', '09'] }, # Mexico
    '53'	=> { area_prefix => '0', intl_prefix => '119' }, # Cuba
    '54'	=> $var,	# Argentina
    '55'	=> $fix2,	# Brazil
    '56'	=> $var,	# Chile
    '57'	=> { area_prefix => '09', intl_prefix => '009' }, # Colombia
    '58'	=> $fix3,	# Venezuela
    '590'	=> $noarea,	# French Antilles
    '591'	=> $fix1,	# Bolivia
    '592'	=> { intl_prefix => '001'}, # Guyana
    '593'	=> $fix1,	# Ecuador
    '594'	=> $noarea,	# French Guiana
    '595'	=> { area_length_min => 2, area_length_max => 4, area_prefix => '0', intl_prefix => '002' }, # Paraguay
    '596'	=> $noarea,	# Martinique
    '597'	=> $noarea,	# Suriname
    '598'	=> $var14,	# Uruguay
    '599'	=> { area_length => 0, area_prefix_alt => [ '0' ], intl_prefix => '00' }, # Netherlands Antilles
    '60'	=> $var12,	# Malaysia
    '61'	=> { area_length => 1, area_prefix => '0', intl_prefix => '0011' }, # Australia
    '62'	=> { area_prefix => '0', intl_prefix => '001' }, # Indonesia
    '63'	=> $var14,	# Philippines
    '64'	=> $var12,	# New Zealand
    '65'	=> { area_length => 0, intl_prefix => '001' }, # Singapore
    '66'	=> { area_length => 0, area_prefix => '0', area_prefix_alt => [''], intl_prefix => '001'}, # Thailand
    '670'	=> $noarea,	# Timor Leste
    '672'	=> $var,	# Australian External Territories
    '673'	=> $noarea,	# Brunei D.
    '674'	=> $noarea,	# Nauru
    '675'	=> $noarea, 	# Papua New Guinea
    '676'	=> $noarea,	# Tonga
    '677'	=> $noarea,	# Solomon Islands
    '678'	=> $noarea,	# Vanuatu
    '679'	=> $noarea,	# Fiji
    '680'	=> { area_length => 0, intl_prefix => '011' }, # Palau
    '681'	=> $noarea,	# Wallis & F.
    '682'	=> $noarea,	# Cook Is.
    '683'	=> $noarea,	# Niue
    '684'	=> $noarea011,	# American Samoa, will be in +1 from 2004-10-02
    '685'	=> { area_length => 0, intl_prefix => '0' }, # Samoa
    '686'	=> $noarea,	# Kiribati
    '687'	=> $noarea,	# New Caledonia
    '688'	=> $noarea,	# Tuvalu
    '689'	=> $noarea,	# French Polynesia
    '690'	=> $noarea,	# Tokelau
    '691'	=> $noarea011,	# Micronesia
    '692'	=> $noarea011,	# Marshall Islands
    '7'		=> { area_length => 3, area_prefix => 8, intl_prefix => '8W10' }, # Russia/Kazakstan
    '7'		=> { area_length_min => 3, area_length_max => 5, %{$cis} }, # Russia
    '81'	=> { area_prefix => '0', intl_prefix => '010' }, # Japan
    '82'	=> { area_length_min => 1, area_length_max => 2, area_prefix => '0', intl_prefix => '001' }, # South Korea
    '84'	=> $var13,	# Viet Nam
    '850'	=> { },		# North Korea
    '852'	=> $noarea,	# Hong Kong
    '852'	=> $noarea,	# Macao
    '855'	=> { area_length => 2, area_prefix => '0', intl_prefix => '001' }, # Cambodia
    '856'	=> $fix2,	# Laos
    '86'	=> $var,	# China
    '880'	=> $var,	# Bangladesh
    '886'	=> { area_length_min => 1, area_length_max => 2, area_prefix => '0', intl_prefix => '002' }, # Taiwan
    '90'	=> $fix3,	# Turkey
    '91'	=> $var,	# India
    '92'	=> $var25,	# Pakistan
    '93'	=> $fix2,  	# Afghanistan
    '94'	=> $var12,	# Sri Lanka
    '95'	=> { },		# Myanmar
    '960'	=> $noarea,	# Maledives
    '961'	=> $fix1, 	# Lebanon
    '962'	=> $fix1,	# Jordan
    '963'	=> $fix2,	# Syria
    '964'	=> $var,	# Iraq
    '965'	=> $noarea,	# Kuwait
    '966'	=> $fix1,	# Saudia Arabia
    '967'	=> $var12,	# Yemen
    '968'	=> $noarea,	# Oman
    '970'	=> $fix1,	# Palestine
    '971'	=> $var12,	# UAE
    '972'	=> $var,	# Israel
    '973'	=> $noarea,	# Bahrain
    '974'	=> $noarea,	# Qatar
    '975'	=> $fix1,	# Bhutan
    '976'	=> { area_length_min => 1, area_length_max => 2, area_prefix => '0', intl_prefix => '001' }, # Mongolia
    '977'	=> $var12,	# Nepal
    '98'	=> { area_length => 3, area_prefix => '0', intl_prefix => '00' }, # Iran
    '992'	=> $cis,	# Tajikistan
    '993'	=> { area_length_min => 2, area_length_max => 3, %{$cis} },	# Turkmenistan
    '994'	=> $cis,	# Azerbaijan
    '995'	=> $cis,	# Georgia
    '996'	=> $var,	# Kyrgyz Rep.
    '998'	=> { area_length => 2, %{$cis} }, # Usbekistan
);

my %alias_codes = (
  '2685'	=> '266',
  '2686'	=> '258',
  '268727'	=> '27',
);

sub _prefix2re {
  my $prefix = '';
  foreach (grep { defined $_} @_) { s/[^[:digit:]]//g; $prefix .= $_.'|' if $_ ne ''; }
  return undef unless $prefix ne '';
  
  $prefix =~ s/\|$//;
  $prefix =~ s/([[:alnum:]])([[:alnum:]])/$1.'[^[:alnum:]]*'.$2/ge;
  $prefix =~ s/2/[2ABCabc]/g;
  $prefix =~ s/3/[3DEFdef]/g;
  $prefix =~ s/4/[4GHIghi]/g;
  $prefix =~ s/5/[5JKLjkl]/g;
  $prefix =~ s/6/[6MNOmno]/g;
  $prefix =~ s/7/[7PQRSpqrs]/g;
  $prefix =~ s/8/[8TUVtuv]/g;
  $prefix =~ s/9/[9WXYZwxyz]/g;
  return qr/^[^[:alnum:]]*(?:$prefix)[^[:alnum:]]*/;
}

sub _norm {
  my $num = shift;
  $num =~ s/[ABCabc]/2/g;
  $num =~ s/[DEFdef]/3/g;
  $num =~ s/[GHIghi]/4/g;
  $num =~ s/[JKLjkl]/5/g;
  $num =~ s/[MNOmno]/6/g;
  $num =~ s/[PQRSpqrs]/7/g;
  $num =~ s/[TUVtuv]/8/g;
  $num =~ s/[WXYZwxyz]/9/g;
  $num =~ s/[^0-9]//g;
  return $num;
}

sub _norm2 {
  my $num = shift;
  $num =~ s/[\(\)]/-/g;
  $num =~ s/^[^[:alnum:]-]/ /g;
  $num =~ s/(\s*-+)+\s*/-/g;
  $num =~ s/\s+/ /g;
  $num =~ s/^[\s-]*//;
  $num =~ s/[\s-]*$//;
  return $num;
};

sub _splitcc {
  my $num = shift;
  my @res = ();

  if($num =~ m/(^[^[:alnum:]]*[17PQRS][^[:alnum:]]*)(.*)/) {
    return wantarray ? ($1, $2) : $1;
  }

  if($num =~ m/(^[^[:alnum:]]*[[:alnum:]][^[:alnum:]]*[[:alnum:]][^[:alnum:]]*)(.*)/) {
    return wantarray ? ($1, $2) : $1  if exists $country_info{_norm($1)};
  }
  
  if($num =~ m/(^[^[:alnum:]]*[[:alnum:]][^[:alnum:]]*[[:alnum:]][^[:alnum:]]*[[:alnum:]][^[:alnum:]]*)(.*)/) {
    return wantarray ? ($1, $2) : $1;
  };

  return undef;
};

sub new {
  my ($class,%params) = @_;
  my $self = bless {}, ref($class) || $class;
  %{$self} = %{$class} if (ref $class);
  foreach (keys %params) {
    my $proc = $self->can('set_'.$_);
    $proc->($self,$params{$_}) if $proc;
  };
  return $self;
};

sub _self {
  my($self, %params) = @_;
  return $self->new(%params) if (!ref($self)) || %params;
  return $self;
};

sub set_own_prefix {
  my($self,$prefix) = @_;
  my($cc,$area) = _splitcc($prefix);
  $self->set_own_country(_norm($cc));
  $self->set_own_area(_norm($area));
};

sub set_own_area {
  my($self,$ac) = @_; $ac = _norm($ac);
  $self->{own_area} = $ac;
  $self->{own_area_re} = _prefix2re($ac);
}

sub _clear_country {
  my $self = shift;
  foreach(keys %{$self}) {
    delete $self->{$_} if m/^(area_|intl_)/;
  }
};

sub set_own_country {
  my($self,$cc) = @_; $cc = _norm($cc);
  $self->{own_country} = $cc;
  $self->{own_country_re} = _prefix2re($cc);
  $self->_clear_country;
  %{$self} = (%{$self}, %{$country_info{$cc}});
  $self->{'area_prefix_re'} = _prefix2re($$self{area_prefix}, @{$$self{'area_prefix_alt'}}) 
    if defined $self->{'area_prefix'} || defined $self->{'area_prefix_alt'};
  $self->{'intl_prefix_re'} = _prefix2re($$self{intl_prefix}, @{$$self{'intl_prefix_alt'}}) 
    if defined $self->{'intl_prefix'} || defined $self->{'intl_prefix_alt'};
}

sub intl {
  my($self,$num) = @_; $self = _self($self, @_);

  if((defined $$self{intl_prefix_re}) && $num =~ m/($$self{intl_prefix_re})(.*)/) {
    $num = $2;
  }
  elsif((defined $$self{area_prefix_re}) && $num =~ m/($$self{area_prefix_re})(.*)/) {
    $num = $$self{own_country}.'-'.$2;
  }
  elsif($num =~ m/^[^[:alnum:]]*\+/) {
    # noop
  }
  elsif((defined($$self{area_length}) && $$self{area_length} == 0) ||
    ($$self{own_country} eq '1' && (length _norm $num) > 9 && 
     $num !~ m/^[^[:alnum:]]*[[:alnum:]]{3,3}[^[:alnum:]]*[[:alnum:]]{4,4}[^0-9]+/ ) ) {
    $num = $$self{own_country}.'-'.$num;
  }
  elsif($$self{own_country}) {
    $num = $$self{own_area}.'-'.$num if $$self{own_area};
    $num = $$self{own_country}.'-'.$num;
  }
  else {
    return undef;
  }
  
  return '+'._norm2($num);
}

sub set_CountryCode { set_own_country(@_); }
sub set_AreaCode { set_own_area(@_); }
sub set_LDPrefix { set_area_prefix(@_); }
sub set_IntlPrefix { set_intl_prefix(@_); }

sub phone_intl { intl(__PACKAGE__, @_); };
sub phone_uri { uri(__PACKAGE__, @_); };
sub phone_national { national(__PACKAGE__, @_); };
sub phone_local { national(__PACKAGE__, @_); };

1;

__END__

=head1 NAME

Number::Phone::Normalize - Normalizes format of Phone Numbers.

=head1 SYNOPSIS

  use Number::Phone::Normalize;
  $a = "089 35709492";
  print phone_intl($a, 'LDPrefix' => '0', 'IntlPrefix' => '00',
    'CountryCode' => '49', 'AreaCode' => '89');

=head1 DESCRIPTION

  This module takes a phone (or E.164) number in different input formats and
  outputs it in accordance to E.123.
