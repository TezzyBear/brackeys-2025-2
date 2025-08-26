extends Panel

class_name UIFatigue

@onready var progress_bar: ProgressBar = $ProgressBar
@onready var label: Label = $ProgressBar/Label

signal on_fatigue_treshold_reached()

func update(value):
	var capped_value = min(100, value)
	if capped_value == 100:
		on_fatigue_treshold_reached.emit()
	progress_bar.value = capped_value
	var formatted = String.num(capped_value, 1)
	if formatted.ends_with(".0"):
		formatted = formatted.substr(0, formatted.length() - 2)
	label.text = "%s/100" % formatted
