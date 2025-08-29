extends Node

class_name FeatherStepBuffBehaviour

var increase_to_hit = 2

func behaviour(required_entities: Dictionary[String, Callable]):
	var dig_scene_manager = required_entities.dig_scene_accesor.call() as DigSceneManager
	dig_scene_manager.hit_bonus += increase_to_hit

func remove(required_entities: Dictionary[String, Callable]):
	var dig_scene_manager = required_entities.dig_scene_accesor.call() as DigSceneManager
	dig_scene_manager.hit_bonus -= increase_to_hit
