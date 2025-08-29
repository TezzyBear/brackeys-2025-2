extends Node

class_name ActiveBuffAgent

var resource: BuffResource # Serves as template before application! ...As each buff is individual
var required_entities: Dictionary[String, Callable] # Callable returns entity
var modifiers: Dictionary[String, Variant]
var computed_description: String
var timer: Timer

func activate(manager_node: BuffManager, behaviour: Callable) -> void:
	manager_node.add_child(self)
	
	if required_entities:
		behaviour.bind(required_entities).call()
	else:
		behaviour.call()
		
	timer = Timer.new()
	add_child(timer)
	timer.start(resource.duration)
	timer.timeout.connect(manager_node.remove_buff.bind(self))
