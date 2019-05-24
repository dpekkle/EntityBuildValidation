package Validators;
sub get_enum_validator
{
	my ($generator_params) = @_;
	my $valid_options = $generator_params->{valid_options} || [];

	return sub {
		my ($validator_params) = @_;

		return $generator_params if $validator_params->{get_generator_params};

		my $table              = $validator_params->{table};
		my $field_name         = $validator_params->{field}->{name};
		my $value              = $validator_params->{value};

		require List::Util;
		my $valid = (List::Util::any { $_ eq ($value // '') } @$valid_options) ? 1 : 0;

		return 1 if $valid;

		my $valid_options_string = join ', ', @{$valid_options};

		my $description
		  = scalar @$valid_options
		  ? "Value supplied is not a valid column option."
		  : "No valid enum options were found, are you sure you have implemented a validation utility for this table : '$table'?";

		die "shit i died";
	};
}

1;
