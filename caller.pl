#!/usr/bin/perl
use FindBin;
use lib "$FindBin::Bin/";

use Builder;
my $timeline_entry_type_options = Builder::get_valid_field_options({ table => 'timeline_entry', field => 'type'});

use Data::Dumper;
warn Dumper $timeline_entry_type_options;