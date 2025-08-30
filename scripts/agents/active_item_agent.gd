extends Node

class_name ActiveItemAgent

var resource: ItemResource # Serves as template before application! ...As each item is individual
var linked_buffs: Array[ActiveBuffAgent] = []
var behaviour: Callable

func consume():
	behaviour.call()

func apply_item():
	for buff_modifier_entry in resource.buff_modifier_entries:
		if not resource.consumable and buff_modifier_entry:
			var active_buff = GameManager.instance.add_buff(buff_modifier_entry.buff, buff_modifier_entry.modifier)
			linked_buffs.append(active_buff)
