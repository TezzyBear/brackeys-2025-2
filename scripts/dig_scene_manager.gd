extends SceneManager

class_name DigSceneManager

const DIRT_TEXTURE = preload("res://assets/images/bgs/bg_dirt.jpg")
const STONE_TEXTURE = preload("res://assets/images/bgs/bg_stone.jpg")
const GOLD_TEXTURE = preload("res://assets/images/bgs/bg_gold.jpg")

@onready var pick: Pick = $CanvasGame/Pick

var current_diggable_health: int
@onready var texture_rect: TextureRect = $CanvasGame/TextureRect

func _ready() -> void:
	GameManager.instance.dig_scene = self
	pick.on_dig.connect(_handle_pick_hit)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("hack_1"):
		GameManager.instance.run_step()

func _get_diggable_texture(diggable: Enums.STEP_TYPE):
	match diggable:
		Enums.STEP_TYPE.DIRT:
			return DIRT_TEXTURE
		Enums.STEP_TYPE.STONE:
			return STONE_TEXTURE
		Enums.STEP_TYPE.GOLD:
			return GOLD_TEXTURE

func _get_diggable_health(diggable: Enums.STEP_TYPE):
	match diggable:
		Enums.STEP_TYPE.DIRT:
			return 5
		Enums.STEP_TYPE.STONE:
			return 15
		Enums.STEP_TYPE.GOLD:
			return 8

func _get_intensity_damage(intensity: Enums.DIG_INTENSITY):
	match intensity:
		Enums.DIG_INTENSITY.LOW:
			return 1
		Enums.DIG_INTENSITY.MID:
			return 2
		Enums.DIG_INTENSITY.HIGH:
			return 4

func _handle_pick_hit(intensity: Enums.DIG_INTENSITY) -> void:
	current_diggable_health -= _get_intensity_damage(intensity)
	print(current_diggable_health)
	if current_diggable_health <= 0:
		pick.set_block(true)
		GameManager.instance.run_step()
		var current_step: Step = GameManager.instance.get_current_step()
		if current_step.diggable:
			_transition_to_diggable(current_step)
		else:
			_transition_to_interaction()

func _transition_to_diggable(diggable: Step, first: bool = false):
	current_diggable_health = _get_diggable_health(diggable.type)
	_transition_bg(diggable, first)

func _transition_bg(diggable: Step, first: bool = false) -> void:
	if not first: await GameManager.instance.transition_manager.fade_out()
	texture_rect.texture = _get_diggable_texture(diggable.type)
	pick.set_block(false)
	await GameManager.instance.transition_manager.fade_in()

func _transition_to_interaction() -> void:
	await GameManager.instance.transition_manager.fade_out()
	GameManager.instance.dig_scene = null
	GameManager.instance.transition_to_scene(load("res://scenes/interaction.tscn"))

func travel_to_step(step_index: int) -> void:
	var step = GameManager.instance.get_step_at(step_index)
	_transition_to_diggable(step, true)
	super(step_index)
