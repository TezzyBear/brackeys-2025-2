extends Node

class_name TimeFreezeBuffBehaviour

static func behaviour(time_ui: UITime):
	time_ui.is_rotating = false

static func remove(time_ui: UITime):
	time_ui.is_rotating = true
