extends Node

class_name PotionOfRejuvenationBehaviour

static func behaviour():
	GameManager.instance.add_fatigue(-20)
