extends Node

class_name GameManager

static var instance: GameManager

const STEPS_TO_WIN = 30
const TIME_TO_LOSE: float = 480

@onready var camera_2d: ShakeCamera = $Camera2D
@onready var transition_manager: TransitionManager = $TransitionManager
@onready var fatigue_manager: FatigueManager = $FatigueManager
@onready var canvas_ui: CanvasLayer = $CanvasUI
@onready var sound_ui: UISound = $CanvasUI/PanelSound
@onready var fatigue_ui: UIFatigue = $CanvasUI/PanelFatigue
@onready var gold_ui: UIGold = $CanvasUI/PanelGold
@onready var time_ui: UITime = $CanvasUI/PanelTime
@onready var inventory_ui: UIInventory = $CanvasUI/PanelInventory

@export var items: Array[Item]

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
var inventory: Array[Item] = [null, null, null, null, null]

func _ready() -> void:
	if not instance:
		GameManager.instance = self
	
	var random_chunk = Chunks.get_random_chunk(Enums.CHUNK_TYPE.DIRT)
	add_chunk(random_chunk)
	
	transition_to_scene(load("res://scenes/dig.tscn"))
	_initialize_time_wheel()
	_initialize_sound_bar()
	fatigue_ui.on_fatigue_treshold_reached.connect(_handle_fatigue_treshold_reached)
	
	#NO BORRAR - necesario para pruebas de inventario
	var item_dups: Array[Item] = []
	item_dups.resize(items.size())
	for i in range(items.size()):
		item_dups[i] = items[i].duplicate(true)
	for i in range(item_dups.size()):
		item_add(item_dups[i])

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("hack_1"):
		run_step()
	if Input.is_action_just_pressed("hack_2"):
		_add_gold(100)
	if Input.is_action_just_pressed("hack_3"):
		_add_fatigue(33)

func _add_gold(value) -> void:
	var uncapped_gold = gold + value
	gold = min(999, max(0, uncapped_gold))
	gold_ui.update(gold)

func _add_fatigue(value) -> void:
	var uncapped_fatigue = fatigue + value
	fatigue = min(100, max(0, uncapped_fatigue))
	fatigue_ui.update(fatigue)

func _handle_fatigue_treshold_reached():
	
	fatigue_manager.animate_fatigue_with_callback(func():
		_add_gold(-30)
		_add_fatigue(-80)
		time_ui.shift_time(120)
	)

func _handle_pick_hit(intensity: Enums.DIG_INTENSITY) -> void:
	_add_gold(_get_gold_in_step_by_pick_hit_intensity(intensity))
	_add_fatigue(0.2 + 1 * intensity)
	sound_ui.sound_increase(intensity)

func _initialize_time_wheel():
	time_ui.start(TIME_TO_LOSE)
	time_ui.on_time_end.connect(_setup_lose)

func _initialize_sound_bar():
	sound_ui.update_bar_treshold(float(level_index) / STEPS_TO_WIN)
	sound_ui.on_sound_treshold_passed.connect(_setup_lose)

func _setup_lose():
	loss_pending = true

func run_step():
	if dig_scene and loss_pending:
		canvas_ui.visible = false
		dig_scene.handle_loss()
		return
		
	level_index += 1
	print("Position: ", level_index)
	
	var current_step: Step = get_current_step()
	
	await transition_manager.fade_out()
	sound_ui.update_bar_treshold(float(level_index) / STEPS_TO_WIN)
	
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

func item_add(item: Item) -> bool:
	for i in range(inventory.size()):
		if inventory[i] == null:
			inventory[i] = item
			inventory_ui.place_item(item, i)
			return true
	return false

func item_delete(slot_id: int) -> bool:
	var is_deleted: bool = inventory_ui.delete_item(slot_id)
	return is_deleted
