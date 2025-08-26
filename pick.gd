extends Node2D

class_name Pick

const HITS_PER_INTENSITY := [5, 8, INF]
const ANIM_PER_INTENSITY := ["pick_hit_soft", "pick_hit_mid", "pick_hit_hard"]

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var block := false
var digging := false
var digging_intensity := Enums.DIG_INTENSITY.LOW
var hits_since_dig_start := 0

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
	_play_hit_by_intensity()

func _stop_digging() -> void:
	digging = false
	animation_player.stop()

func _animation_player_dig_hit() -> void:
	# TODO: Add sound
	var shake_strenght = _get_shake_strenght_for_intensity(digging_intensity)
	ShakeCamera.apply_shake(shake_strenght)
	
	on_dig.emit(digging_intensity)
	
	hits_since_dig_start += 1
	if hits_since_dig_start > HITS_PER_INTENSITY[digging_intensity]:
		digging_intensity += 1	

func _animation_finished_loop() -> void:
	_play_hit_by_intensity()

func _play_hit_by_intensity():
	animation_player.play(ANIM_PER_INTENSITY[digging_intensity])

func _get_shake_strenght_for_intensity(intensity: Enums.DIG_INTENSITY):
	match intensity:
		Enums.DIG_INTENSITY.LOW:
			return 0
		Enums.DIG_INTENSITY.MID:
			return 3
		Enums.DIG_INTENSITY.HIGH:
			return 10
			
func set_block(value: bool):
	if block != value:
		block = value
		if block:
			_stop_digging()
		
