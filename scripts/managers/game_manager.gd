extends Node

class_name GameManager

static var instance: GameManager

const STEPS_TO_WIN = 30

@onready var transition_manager: TransitionManager = $TransitionManager
@onready var canvas_ui: CanvasLayer = $CanvasUI

var rendered_scene: SceneManager = null
var dig_scene: DigSceneManager = null
var interaction_scene: InteractionSceneManager = null

# Progress Variables
var level_index := 0 # Position in level
var level_layout := [] 

# Player Stats
var time_steps_passed := 0
var fatigue := 0.0 #cap 100
var weight := 0.0
var gold := 0

func _ready() -> void:
	if not instance:
		GameManager.instance = self
	
	var random_chunk = Chunks.get_random_chunk(Enums.CHUNK_TYPE.DIRT)
	add_chunk(random_chunk)
	
	transition_to_scene(load("res://scenes/dig.tscn"))

func _process(delta: float) -> void:
	pass

func _add_gold(value) -> void:
	gold += value
	(canvas_ui.get_node("PanelGold") as UIGold).update(gold)

func _add_fatigue(value) -> void:
	fatigue += value
	(canvas_ui.get_node("PanelFatigue") as UIFatigue).update(fatigue)

func _handle_pick_hit(intensity: Enums.DIG_INTENSITY) -> void:
	match get_current_step().type:
		Enums.STEP_TYPE.GOLD:
			_add_gold((intensity + 1) * randi_range(1, 3))
			
	_add_fatigue(0.2)
	(canvas_ui.get_node("PanelSound") as UISound).sound_increase(intensity)

func run_step():
	level_index += 1
	(canvas_ui.get_node("PanelSound") as UISound).restart(level_index)
	
	var current_step: Step = get_current_step()
	
	await transition_manager.fade_out()
	
	if rendered_scene is InteractionSceneManager:
		transition_to_scene(load("res://scenes/dig.tscn"))
	else:
		if current_step.diggable:
			(rendered_scene as DigSceneManager).update_diggable(current_step)
		else:
			transition_to_scene(load("res://scenes/interaction.tscn"))

func transition_to_scene(scene: PackedScene):
	if rendered_scene:
		rendered_scene.queue_free()
		
	rendered_scene = scene.instantiate()
	
	get_tree().current_scene.add_child(rendered_scene)
	rendered_scene.travel_to_step(level_index)
	dig_scene.pick.on_dig.connect(_handle_pick_hit)
	
	await transition_manager.fade_in()

func add_chunk(chunk: Array):
	level_layout += chunk + [Step.create(Enums.STEP_TYPE.PATH_SELECTION, false)]
	var pretty_print_str = ''
	for step in level_layout:
		pretty_print_str += str(step.type) +', '
	print(pretty_print_str)

func get_current_step() -> Step:
	return level_layout[level_index]

func get_step_at(step_index) -> Step:
	return level_layout[step_index]
