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

func sound_increase(noise: int) -> void:
	progress_bar.value += noise
	progress_bar_warning_update()

func progress_bar_warning_update() -> void:
	if progress_bar.value >= 100 - tresholdValue:
		warning.visible = true

func _process(delta: float) -> void:
	decrease_progress(delta)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			sound_increase(5)

func decrease_progress(delta: float) -> void:
	progress_bar.value -= 3 * delta
	if progress_bar.value < 0:
		progress_bar.value = 0
