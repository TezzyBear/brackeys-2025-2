extends Buff

@export var increase_to_hit = 2

func activate(agent: BuffApplicationAgent) -> void:
	increase_to_hit = agent.modifiers.str[0]
	var dig_scene_manager = agent.required_entities.dig_scene.call() as DigSceneManager
	
	dig_scene_manager.hit_bonus += increase_to_hit

func remove(agent: BuffApplicationAgent) -> void:
	var dig_scene_manager = agent.required_entities.dig_scene.call() as DigSceneManager
	
	dig_scene_manager.hit_bonus -= increase_to_hit
