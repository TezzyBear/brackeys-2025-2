extends Node

class_name GameManager

static var instance: GameManager

const STEPS_TO_WIN = 30
const TIME_TO_LOSE: float = 480

@onready var camera_2d: ShakeCamera = $Camera2D
@onready var transition_manager: TransitionManager = $TransitionManager
@onready var canvas_ui: CanvasLayer = $CanvasUI

var rendered_scene: SceneManager = null
var dig_scene: DigSceneManager = null
var interaction_scene: InteractionSceneManager = null
var loss_pending := false

# Progress Variables
var level_index := 0 # Position in level
var level_layout := [] 

# Player Stats
var time_steps_passed := 0
var fatigue := 0.0 #cap 100
var gold := 0

func _ready() -> void:
	if not instance:
		GameManager.instance = self
	
	var random_chunk = Chunks.get_random_chunk(Enums.CHUNK_TYPE.DIRT)
	add_chunk(random_chunk)
	
	transition_to_scene(load("res://scenes/dig.tscn"))
	_initialize_time_wheel()
	

func _process(delta: float) -> void:
	pass

func _add_gold(value) -> void:
	gold += value
	(canvas_ui.get_node("PanelGold") as UIGold).update(gold)

func _add_fatigue(value) -> void:
	fatigue += value
	(canvas_ui.get_node("PanelFatigue") as UIFatigue).update(fatigue)

func _handle_pick_hit(intensity: Enums.DIG_INTENSITY) -> void:
	print("A")
	_add_gold(_get_gold_in_step_by_pick_hit_intensity(intensity))
	_add_fatigue(0.2 + 1 * intensity)
	(canvas_ui.get_node("PanelSound") as UISound).sound_increase(intensity)

func _initialize_time_wheel():
	var ui_time: UITime = canvas_ui.get_node("PanelTime")
	ui_time.start(TIME_TO_LOSE)
	ui_time.on_time_end.connect(_setup_lose)
	
func _setup_lose():
	loss_pending = true

func run_step():
	if dig_scene and loss_pending:
		dig_scene.handle_loss()
		return
		
	level_index += 1
	print("Position: ", level_index)
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
	camera_2d.add_child(rendered_scene)
	
	if rendered_scene is DigSceneManager:
		rendered_scene.pick.on_dig.connect(_handle_pick_hit) # <- This needs to be before, so it logs gold previous to ran step
		rendered_scene.connect_signal_handlers()
		
	rendered_scene.travel_to_step(level_index)
	
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
	
# Mapping
func _get_gold_in_step_by_pick_hit_intensity(intensity: Enums.DIG_INTENSITY):
	match get_current_step().type:
		Enums.STEP_TYPE.GOLD:
			return(intensity + 1) * randi_range(1, 3)
		_:
			return 1 if randi_range(0, 3) == 3 else 0
		
