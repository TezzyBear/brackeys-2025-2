extends Node

class_name GameManager

static var instance: GameManager

const MAX_TIME_STEPS = 30

@onready var transition_manager: TransitionManager = $TransitionManager

var rendered_scene: Node = null
var dig_scene: DigSceneManager = null
var interaction_scene: InteractionSceneManager = null

# Progress Variables
var level_index := 0 # Position in level
var level_layout := [] 

# Player Stats
var time_steps_passed := 0
var fatigue := 0 #cap 100
var weight := 0

func _ready() -> void:
	if not instance:
		GameManager.instance = self
	
	var random_chunk = Chunks.get_random_chunk(Enums.CHUNK_TYPES.DIRT)
	add_chunk(random_chunk)
	transition_to_scene(load("res://scenes/dig.tscn"))	

func _process(delta: float) -> void:
	pass
	
func run_step():
	level_index += 1
	if not dig_scene: return
	
	var step_result: Enums.STEP = level_layout[level_index]
	if step_result < 3:
		dig_scene.transition_to_bg(step_result)
	else:
		dig_scene.transition_to_interaction(step_result)

func transition_to_scene(scene: PackedScene):
	if rendered_scene:
		rendered_scene.queue_free()
	rendered_scene = scene.instantiate()
	get_tree().current_scene.add_child(rendered_scene)
	await transition_manager.fade_in()
	
func add_chunk(chunk: Array):
	level_layout += chunk + [Enums.STEP.SELECTION]
	print(level_layout)
