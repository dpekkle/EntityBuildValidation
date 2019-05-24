package Builder;

sub get_builder_from_table
{
	my ($table) = @_;

	my $builder_map = {
		timeline_entry => 'Entity::Timeline_Entry',
	};

	return $builder_map->{$table};
}

sub get_valid_field_options
{
	my ($details) = @_;

	my $table = $details->{table} || die;
	my $column = $details->{field} || die;

	my $builder_package_name = get_builder_from_table($table);

	my $fields = dynamically_call_package($builder_package_name, 'get_fields');

	my $field = [grep { $_->{name} eq $column } @$fields]->[0];

	my $validator = $field->{validators}->[0]; #TODO Can't just assume it is the first one, see has_the_validator logic for solution

	return $validator->({get_generator_params => 1});
}

sub dynamically_call_package
{
	my ($package_name, $function_name, $params) = @_;

	# A dynamic require must be called on a path in the form utility/job.pm, not utility::job
	my $path = $package_name;
	$path =~ s/::/\//g;
	$path .= '.pm';
	require $path;

	# Will actually return a coderef that we can call without worrying about the class being the first param when called,
	# Meaning we don't have to do something like `my $self = shift if ($_[0] eq 'Package::Foo')` in the function we are calling
	my $coderef = $package_name->can($function_name);

	return $params ? $coderef->($params) : $coderef->();
}

1;