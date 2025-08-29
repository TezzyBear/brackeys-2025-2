extends Node

class_name GlassOfStillSandsBehaviour

static func behaviour(time_ui: UITime, buff: BuffResource):
	GameManager.instance.add_buff(buff)
