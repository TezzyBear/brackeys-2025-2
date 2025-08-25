class_name Step

var type: Enums.STEP_TYPE
var diggable: bool
var extra_data

static func create(type: Enums.STEP_TYPE, diggable: bool = false, extra_data = null):
	var created = Step.new()
	created.type = type
	created.diggable = diggable
	created.extra_data = extra_data
	return created
