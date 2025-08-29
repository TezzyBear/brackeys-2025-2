extends Node

class_name ActiveItemAgent

var resource: ItemResource # Serves as template before application! ...As each item is individual
var linked_buffs: Array[ActiveBuffAgent]
var behaviour: Callable

func consume():
	behaviour.call()

func apply_item():
	pass
	#for buff_modifier_entry in buff_modifier_entries:
	#	if not consumable and buff_modifier_entry:
	#		var modifiers: Dictionary[String, Variant] = { "str": buff_modifier_entry.modifiers }
	#		GameManager.instance.add_buff(buff_modifier_entry.buff, modifiers)
