extends Resource

class_name Item

@export var name: String
@export var rarity: Enums.RARITY
@export var cost: int
@export var effect: String
@export var consumable: bool
@export var description: String
@export var texture: Texture2D
@export var buff_modifier_entries: Array[BuffEntry]
#@export var buff_modifiers: Array

func apply_item():
	for buff_modifier_entry in buff_modifier_entries:
		if buff_modifier_entry:
			var modifiers: Dictionary[String, Variant] = { "str": buff_modifier_entry.modifiers }
			GameManager.instance.add_buff(buff_modifier_entry.buff, modifiers)
