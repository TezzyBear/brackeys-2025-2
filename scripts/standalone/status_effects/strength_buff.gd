extends Buff

@export var increase_to_hit = 2

func activate(target: Node) -> void:
	var dig_scene_manager = target as DigSceneManager
	
	description = description.replace("{value}", str(increase_to_hit))
	dig_scene_manager.hit_bonus += increase_to_hit

func remove(target: Node) -> void:
	var dig_scene_manager = target as DigSceneManager
	
	dig_scene_manager.hit_bonus -= increase_to_hit
