extends Node

class_name FatigueManager

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func animate_fatigue_with_callback(cb: Callable):
	animation_player
	animation_player.play("pass_out")
	await animation_player.animation_finished
	cb.call()
	animation_player.play_backwards("pass_out")
	await animation_player.animation_finished
