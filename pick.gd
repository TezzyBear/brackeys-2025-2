extends Node2D

class_name Pick

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var block := false
var digging := false
var digging_intensity := Enums.DIG_INTENSITY.LOW
var hits_since_dig_start := 0
const HITS_PER_INTENSITY := 2

signal on_dig(intensity: Enums.DIG_INTENSITY)

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	if block: return
	
	if Input.is_action_just_pressed("click"):
		_start_digging()
	if Input.is_action_just_released('click'):
		_stop_digging()
	
func _start_digging() -> void:
	digging = true
	hits_since_dig_start = 0
	digging_intensity = 0
	animation_player.play("pick")

func _stop_digging() -> void:
	digging = false
	animation_player.stop()

func _animation_player_dig_hit() -> void:
	# TODO: Add sound
	print("Hit!")
	hits_since_dig_start += 1
	var intensity = min((hits_since_dig_start - 1) / HITS_PER_INTENSITY, Enums.DIG_INTENSITY.HIGH)
	on_dig.emit(intensity)

func set_block(value: bool):
	if block != value:
		block = value
		if block:
			_stop_digging()
		
