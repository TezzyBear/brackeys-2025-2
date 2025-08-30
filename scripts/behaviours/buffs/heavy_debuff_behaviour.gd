extends Node

class_name HeavyDebuffBehaviour

static func behaviour(modifier):
	GameManager.instance.weight_multiplier += modifier

static func remove(modifier):
	GameManager.instance.weight_multiplier -= modifier
