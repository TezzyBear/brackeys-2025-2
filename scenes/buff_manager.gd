extends Node

class_name BuffManager

@onready var canvas_ui: CanvasLayer = $"../CanvasUI"
@onready var buffs_ui: UIBuffs

var buffs: Array[Buff] = [
	load("res://assets/data/status_effects/feather_step_buff.tres"),
	load("res://assets/data/status_effects/heavy_debuff.tres"),
	load("res://assets/data/status_effects/stamina_buff.tres"),
	load("res://assets/data/status_effects/strength_buff.tres"),
	load("res://assets/data/status_effects/time_freeze_buff.tres")
]

func _ready():
	buffs_ui = canvas_ui.get_node("PanelBuffs")

func apply_buff(buff: Buff, modifiers: Dictionary[String, Variant]):
	var agent = BuffApplicationAgent.new()
	agent.required_entities = buff_required_entities[buff]
	
	if modifiers.size():
		agent.modifiers = modifiers
		var modifier_str = str(modifiers.values()[0][0]) # Consider later adding multiple modifiers per buff. For now it will only work with 1
		print(buff.description)
		agent.computed_description = buff.description.replace("{value}", modifier_str)
	buff.activate(agent)
	buffs_ui.place_buff(buff, agent.computed_description)

# Mappings
var buff_required_entities: = {
	buffs[0]: {"dig_scene": (func(): return GameManager.instance.dig_scene)} as Dictionary[String, Variant],
	buffs[1]: {"dig_scene": (func(): return GameManager.instance.dig_scene)} as Dictionary[String, Variant],
	buffs[2]: {"dig_scene": (func(): return GameManager.instance.dig_scene)} as Dictionary[String, Variant],
	buffs[3]: {"dig_scene": (func(): return GameManager.instance.dig_scene)} as Dictionary[String, Variant],
	buffs[4]: {"dig_scene": (func(): return GameManager.instance.dig_scene)} as Dictionary[String, Variant]
}
