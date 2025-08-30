extends Panel

class_name UISound

var MAX_TRESHOLD = 50
var MIN_THRESHOLD = 5

@onready var progress_bar: TextureProgressBar = $TextureProgressBar
@onready var warning: TextureRect = $Warning
@onready var treshold_rect: TextureRect = $TextureProgressBar/TextureRect
var treshold_value: int
var treshold_visual_height: int

var noise_multiplier := 1.0

signal on_sound_treshold_passed()

func _ready() -> void:
	warning.visible = false
	treshold_visual_height = progress_bar.size.y / 100

func update_bar_treshold(progress: float) -> void:
	treshold_value = MIN_THRESHOLD + (MAX_TRESHOLD - MIN_THRESHOLD) * progress
	treshold_rect.position.y = treshold_value * treshold_visual_height

func add_sound(value) -> void:
	var uncapped_sound = progress_bar.value + value
	progress_bar.value = min(100, max(0, uncapped_sound))

func sound_increase(intensity: Enums.DIG_INTENSITY) -> void:
	var noise_increment = _get_noise_increment_by_intensity(intensity) * noise_multiplier
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
