extends Node

class_name BuffManager

var buff_behaviours: Dictionary[BuffResource, Callable]
var buff_removers: Dictionary[BuffResource, Callable]
var active_buffs: Array[ActiveBuffAgent] = []

@onready var canvas_ui: CanvasLayer = $"../CanvasUI"
@onready var buffs_ui: UIBuffs

func _ready():
	buffs_ui = canvas_ui.get_node("PanelBuffs")

func initialize_behaviours() -> void:
	buff_behaviours = {
		time_freeze_resource: TimeFreezeBuffBehaviour.behaviour.bind(GameManager.instance.time_ui)
	}
	buff_removers = {
		time_freeze_resource: TimeFreezeBuffBehaviour.remove.bind(GameManager.instance.time_ui)
	}

func apply_buff(buff: BuffResource, modifiers: Dictionary[String, Variant]):
	var agent := ActiveBuffAgent.new()
	agent.resource = buff
	#agent.required_entities = buff_required_entities[buff]
	
	if modifiers.size():
		agent.modifiers = modifiers
		if modifiers.values()[0].size() > 0:
			var modifier_str = str(modifiers.values()[0][0]) # Consider later adding multiple modifiers per buff. For now it will only work with 1
			agent.computed_description = buff.description.replace("{value}", modifier_str)
	
	if agent.computed_description == "":
		agent.computed_description = buff.description
			
	agent.activate(self, buff_behaviours[buff])
	buffs_ui.place_buff(agent)
	add_child(agent)

func remove_buff(agent: ActiveBuffAgent):
	buff_removers[agent.resource].call()
	buffs_ui.delete_buff(agent)
	active_buffs.erase(agent)
	agent.queue_free()
	
# Mappings
var feather_step_resource = load("res://assets/data/status_effects/feather_step_buff.tres")
var heavy_resource = load("res://assets/data/status_effects/heavy_debuff.tres")
var stamina_resource = load("res://assets/data/status_effects/stamina_buff.tres")
var strength_resource = load("res://assets/data/status_effects/strength_buff.tres")
var time_freeze_resource = load("res://assets/data/status_effects/time_freeze_buff.tres")
