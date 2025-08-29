extends Node

class_name TimeFreezeBuffBehaviour

static func behaviour(time_ui: UITime):
	time_ui.is_rotating = false
	print(time_ui.elapsed_time)
	pass

static func remove(time_ui: UITime):
	time_ui.is_rotating = true
	print(time_ui.elapsed_time)
	pass
