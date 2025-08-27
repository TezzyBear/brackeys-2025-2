extends Panel

class_name UISound

var MAX_TRESHOLD = 50
var MIN_THRESHOLD = 5

@export var progress_bar: ProgressBar
@export var warning: TextureRect
@export var treshold_rect: ColorRect
var treshold_value: int

signal on_sound_treshold_passed()

func _ready() -> void:
	warning.visible = false

func update_bar_treshold(progress: float) -> void:
	treshold_value = MIN_THRESHOLD + (MAX_TRESHOLD - MIN_THRESHOLD) * progress
	treshold_rect.position.y = treshold_value * 2

func sound_increase(intensity: Enums.DIG_INTENSITY) -> void:
	var noise_increment = _get_noise_increment_by_intensity(intensity)
	progress_bar.value += noise_increment
	progress_bar_warning_update()

func progress_bar_warning_update() -> void:
	if progress_bar.value >= 100 - treshold_value:
		warning.visible = true
		on_sound_treshold_passed.emit()

func _process(delta: float) -> void:
	_decrease_progress(delta)

func _decrease_progress(delta: float) -> void:
	progress_bar.value -= 5 * delta
	if progress_bar.value <= 100 - treshold_value:
		warning.visible = false
	if progress_bar.value < 0:
		progress_bar.value = 0

# Mapping
func _get_noise_increment_by_intensity(intensity: Enums.DIG_INTENSITY):
	match intensity:
		Enums.DIG_INTENSITY.LOW:
			return 3
		Enums.DIG_INTENSITY.MID:
			return 16
		Enums.DIG_INTENSITY.HIGH:
			return 40
