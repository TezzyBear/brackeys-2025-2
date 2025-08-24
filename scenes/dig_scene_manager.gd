extends Node2D

class_name DigSceneManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.dig_scene = self

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
