package Entity::Timeline_Entry;

use Validators;

sub get_fields
{
	return [{
		# The "type" of metadata. See Validation module
		name => 'type',
		is_editable => 1,
		validators  => [
			Validators::get_enum_validator({
				valid_options => ['person', 'type', 'status', 'text', 'timestamp', 'currency', 'email', 'position'],
			}),
		],
	}];
}

1;