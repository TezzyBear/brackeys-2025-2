extends Panel

class_name UIFatigue

@onready var progress_bar: ProgressBar = $ProgressBar
@onready var label: Label = $ProgressBar/Label

func update(value):
	progress_bar.value = value
	var formatted = String.num(value, 1)
	if formatted.ends_with(".0"):
		formatted = formatted.substr(0, formatted.length() - 2)
	label.text = "%s/100" % formatted
