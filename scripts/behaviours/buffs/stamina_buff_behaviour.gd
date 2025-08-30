extends Node

class_name StaminaBuffBehaviour

static func behaviour(modifier):
	GameManager.instance.stamina_multiplier -= modifier

static func remove(modifier):
	GameManager.instance.stamina_multiplier += modifier
