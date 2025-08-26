extends Camera2D

class_name ShakeCamera

static var shake_strength := 0.0
@export var shake_fade := 2.0

func _ready() -> void:
	pass 

static func apply_shake(strength: float):
	shake_strength = strength

func _process(delta: float) -> void:
	if shake_strength >= 0.01:
		shake_strength = lerpf(shake_strength, 0, shake_fade * delta)
		offset = Vector2(randf_range(-shake_strength, shake_strength), randf_range(-shake_strength, shake_strength))
