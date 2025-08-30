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
	print(GameManager.instance.dig_scene)
	buff_behaviours = {
		feather_step_resource: FeatherStepBuffBehaviour.behaviour.bind(GameManager.instance.sound_ui),
		heavy_resource: HeavyDebuffBehaviour.behaviour.bind(),
		stamina_resource: StaminaBuffBehaviour.behaviour.bind(),
		strength_resource: StrengthBuffBehaviour.behaviour.bind(GameManager.instance.dig_scene),
		time_freeze_resource: TimeFreezeBuffBehaviour.behaviour.bind(GameManager.instance.time_ui)
	}
	buff_removers = {
		feather_step_resource: FeatherStepBuffBehaviour.remove.bind(GameManager.instance.sound_ui),
		heavy_resource: HeavyDebuffBehaviour.remove.bind(),
		stamina_resource: StaminaBuffBehaviour.remove.bind(),
		strength_resource: StrengthBuffBehaviour.remove.bind(GameManager.instance.dig_scene),
		time_freeze_resource: TimeFreezeBuffBehaviour.remove.bind(GameManager.instance.time_ui)
	}

func apply_buff(buff: BuffResource, modifier = null):
	var agent := ActiveBuffAgent.new()
	agent.resource = buff
	#agent.required_entities = buff_required_entities[buff]
	
	# Consider later adding multiple modifiers per buff. For now it will only work with 1
	if modifier:
		agent.modifier = modifier
		agent.computed_description = buff.description.replace("{value}", str(modifier))
	
	if agent.computed_description == "":
		agent.computed_description = buff.description
	
	agent.bind_callbacks(buff_behaviours[buff], buff_removers[buff])
	agent.activate(self)
	buffs_ui.place_buff(agent)
	add_child(agent)
	return agent

func remove_buff(agent: ActiveBuffAgent):
	print(agent.remover)
	agent.remover.call()
	buffs_ui.delete_buff(agent)
	active_buffs.erase(agent)
	agent.queue_free()
	
# Mappings
var feather_step_resource = load("res://assets/data/status_effects/feather_step_buff.tres")
var heavy_resource = load("res://assets/data/status_effects/heavy_debuff.tres")
var stamina_resource = load("res://assets/data/status_effects/stamina_buff.tres")
var strength_resource = load("res://assets/data/status_effects/strength_buff.tres")
var time_freeze_resource = load("res://assets/data/status_effects/time_freeze_buff.tres")
