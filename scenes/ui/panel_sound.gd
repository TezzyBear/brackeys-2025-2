extends Panel
class_name UISound
@export var progress_bar:ProgressBar
@export var warning:TextureRect
@export var tresholdRect:ColorRect
@export var tresholdValue: int

func _ready() -> void:
	restart(0)

func restart(level: int = 0) -> void:
	progress_bar.value = 0
	
	warning.visible = false
	
	var newTreshold: int = (level * 2) + 5
	tresholdValue = newTreshold
	tresholdRect.position.y = tresholdValue * 2

func sound_increase(intensity: Enums.DIG_INTENSITY) -> void:
	var noise_increment: int = 0
	match intensity:
		Enums.DIG_INTENSITY.LOW:
			noise_increment = 4
		Enums.DIG_INTENSITY.MID:
			noise_increment = 8
		Enums.DIG_INTENSITY.HIGH:
			noise_increment = 12
			
	progress_bar.value += noise_increment
	progress_bar_warning_update()

func progress_bar_warning_update() -> void:
	if progress_bar.value >= 100 - tresholdValue:
		warning.visible = true

func _process(delta: float) -> void:
	decrease_progress(delta)

func decrease_progress(delta: float) -> void:
	progress_bar.value -= 3 * delta
	if progress_bar.value < 0:
		progress_bar.value = 0
