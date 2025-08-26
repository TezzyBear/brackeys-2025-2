extends Panel

class_name UITime

@onready var wheel: TextureRect = $Wheel
@onready var pin: TextureRect = $Pin

var rotation_step: float = 22.5
var rotation_duration: float = 480.0
var rotation_per_second = (360.0 - rotation_step) / rotation_duration
var _elapsed_time: float = 0.0
var _is_rotating: bool = false

func start(time_until_lose: float) -> void:
	rotation_duration = time_until_lose
	rotation_per_second = (360.0 - rotation_step) / rotation_duration
	_elapsed_time = 0.0
	_is_rotating = true

func pause() -> void:
	_is_rotating = false

func resume() -> void:
	_is_rotating = true

func _process(delta: float) -> void:
	if _is_rotating:
		wheel_rotate(delta)

func wheel_rotate(delta: float) -> void:
	_elapsed_time += delta
	
	wheel.rotation_degrees += rotation_per_second * delta
	
	if _elapsed_time >= rotation_duration:
		_is_rotating = false
