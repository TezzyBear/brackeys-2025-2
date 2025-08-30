extends Node

class_name StrengthBuffBehaviour

static func behaviour(modifier, dig_scene_manager: DigSceneManager):
	dig_scene_manager.hit_bonus += modifier
	GameManager.instance.strength = dig_scene_manager.hit_bonus

static func remove(modifier, dig_scene_manager: DigSceneManager):
	dig_scene_manager.hit_bonus -= modifier
