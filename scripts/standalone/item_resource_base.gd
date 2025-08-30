extends Resource

class_name ItemResource

@export var name: String
@export var rarity: Enums.RARITY
@export var cost: int
@export var effect: String
@export var consumable: bool
@export var description: String
@export var texture: Texture2D
@export var icon_texure: Texture2D
@export var buff_modifier_entries: Array[BuffEntry]

@export_category("Shop Card")
@export var texture_bg: Texture2D
@export var texture_name: Texture2D
