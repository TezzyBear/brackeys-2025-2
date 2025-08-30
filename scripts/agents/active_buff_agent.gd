extends Node

class_name ActiveBuffAgent

var resource: BuffResource # Serves as template before application! ...As each buff is individual
var modifier: Variant
var computed_description: String
var timer: Timer
var behaviour: Callable
var remover: Callable

func bind_callbacks(behaviour: Callable, remover: Callable):
	if modifier:
		self.behaviour = behaviour.bind(modifier)
		self.remover = remover.bind(modifier)
	else:
		self.behaviour = behaviour
		self.remover = remover

func activate(manager_node: BuffManager) -> void:
	manager_node.add_child(self)
	behaviour.call()
		
	if resource.duration > 0:
		timer = Timer.new()
		add_child(timer)
		timer.start(resource.duration)
		timer.timeout.connect(manager_node.remove_buff.bind(self))
