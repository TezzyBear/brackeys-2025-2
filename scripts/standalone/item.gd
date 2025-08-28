extends Resource

class_name Item

@export var name: String
@export var rarity: Enums.RARITY
@export var cost: int
@export var effect: String
@export var consumable: bool
@export var description: String
@export var texture: Texture2D
@export var buffs: Array[Buff]

func apply_item():
	for buff in buffs:
		if buff:
			GameManager.instance.add_buff(buff)
