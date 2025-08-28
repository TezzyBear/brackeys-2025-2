extends Resource

class_name Buff

@export var description: String
@export var duration: float = 15.0
@export var texture: Texture2D

func activate(agent: BuffApplicationAgent) -> void:
	pass

func remove(agent: BuffApplicationAgent) -> void:
	pass
