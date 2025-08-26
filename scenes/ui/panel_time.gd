extends Panel

class_name UITime

@onready var wheel: TextureRect = $Wheel
@onready var pin: TextureRect = $Pin

var rotation_step: float = 22.5
var rotation_duration: float = 480.0
var rotation_per_second = (360.0 - rotation_step) / rotation_duration
var elapsed_time: float = 0.0
var is_rotating: bool = false

signal on_time_end

func start(time_until_lose: float) -> void:
	rotation_duration = time_until_lose
	rotation_per_second = (360.0 - rotation_step) / rotation_duration
	elapsed_time = 0.0
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
	
	wheel.rotation_degrees += rotation_per_second * delta
	
	if elapsed_time >= rotation_duration:
		is_rotating = false
		on_time_end.emit()
