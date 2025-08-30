extends Node

class_name WhisperingPlumeBehaviour

static func behaviour(buff_modifier_entry: BuffEntry):
	GameManager.instance.add_buff(buff_modifier_entry.buff, buff_modifier_entry.modifier)
