extends Panel

@export var progress_bar:ProgressBar
var direction: bool = true

func _process(delta) -> void:
	progress_bar_alter(delta)
	
	pass


func progress_bar_alter(delta: float) -> void:
	if direction:
		progress_bar.value -= 20 * delta
		if progress_bar.value <= 0:
			direction = false
	else:
		progress_bar.value += 20 * delta
		if progress_bar.value >= 100:
			direction = true

func progress_bar_sparkle() -> void:
	progress_bar.value
	progress_bar
	pass
