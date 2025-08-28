extends Resource

class_name Buff

@export var description: String
@export var duration: float = 15.0
@export var texture: Texture2D

func activate(target: Node) -> void:
	pass

func remove(target: Node) -> void:
	pass
