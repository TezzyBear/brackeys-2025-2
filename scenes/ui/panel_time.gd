extends Panel

class_name UITime

@onready var wheel: TextureRect = $Wheel
@onready var pin: TextureRect = $Pin

var rotation_step: float = 22.5
var rotation_duration: float = 480.0
var elapsed_time: float = 0.0
var is_rotating: bool = false

signal on_time_end

func start(time_until_lose: float) -> void:
	rotation_duration = time_until_lose
	elapsed_time = 0.0
	wheel.rotation_degrees = rotation_step
	is_rotating = true

func pause() -> void:
	is_rotating = false

func resume() -> void:
	is_rotating = true

func _process(delta: float) -> void:
	if is_rotating:
		_wheel_rotate(delta)

func _wheel_rotate(delta: float) -> void:
	elapsed_time += delta
	
	if elapsed_time >= rotation_duration:
		elapsed_time = rotation_duration
		wheel.rotation_degrees = rotation_step + (360.0 - rotation_step)
		is_rotating = false
		on_time_end.emit()
	else:
		wheel.rotation_degrees = rotation_step + (elapsed_time / rotation_duration) * (360.0 - rotation_step)

func shift_time(seconds: float) -> void:
	var previous_elapsed = elapsed_time
	elapsed_time += seconds
	elapsed_time = clamp(elapsed_time, 0.0, rotation_duration)
	wheel.rotation_degrees = rotation_step + (elapsed_time / rotation_duration) * (360.0 - rotation_step)
	if previous_elapsed < rotation_duration && elapsed_time >= rotation_duration:
		is_rotating = false
		on_time_end.emit()
