extends Panel

class_name UIFatigue

@onready var texture_progress_bar: TextureProgressBar = $ProgressBar
@onready var texture_rect: TextureRect = $ProgressBar/TextureRect

signal on_fatigue_treshold_reached()
	
func update(value):
	var capped_value = min(100, value)
	if capped_value == 100:
		on_fatigue_treshold_reached.emit()
	texture_progress_bar.value = capped_value
	
	var fill_ratio = texture_progress_bar.value / texture_progress_bar.max_value
	var filled_width = texture_progress_bar.size.x * fill_ratio
	texture_rect.position.x = filled_width - texture_rect.size.x / 2
