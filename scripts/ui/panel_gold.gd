extends Panel

class_name UIGold

@onready var label: Label = $Label

func update(value):
	var formatted = String.num(value, 1)
	if formatted.ends_with(".0"):
		formatted = formatted.substr(0, formatted.length() - 2)
	label.text = "%s" % formatted
