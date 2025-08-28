extends SceneManager

class_name DigSceneManager

const DIRT_TEXTURE = preload("res://assets/images/bgs/bg_dirt.jpg")
const STONE_TEXTURE = preload("res://assets/images/bgs/bg_stone.jpg")
const GOLD_TEXTURE = preload("res://assets/images/bgs/bg_gold.jpg")

@onready var pick: Pick = $Pick

var current_diggable_health: int
var current_step_type: Enums.STEP_TYPE
@onready var texture_rect: TextureRect = $TextureRect
var hit_bonus := 0

signal on_step_end(current_step_type: Enums.STEP_TYPE)

func _ready() -> void:
	GameManager.instance.dig_scene = self

func _handle_pick_hit(intensity: Enums.DIG_INTENSITY) -> void:
	current_diggable_health -= _get_intensity_damage(intensity) + hit_bonus
	print("Hp: ", current_diggable_health)
	if current_diggable_health <= 0:
		pick.set_block(true)
		on_step_end.emit(current_step_type)
		GameManager.instance.run_step()

func _fade_bg_out_in(diggable: Step) -> void:
	pick.set_block(false)
	texture_rect.texture = _get_diggable_texture(diggable.type)
	await GameManager.instance.transition_manager.fade_in()

func update_diggable(diggable: Step):
	current_diggable_health = _get_diggable_health(diggable.type)
	current_step_type = diggable.type
	_fade_bg_out_in(diggable)

func handle_loss():
	pick.set_block(true)
	texture_rect.texture = load("res://assets/images/bgs/bg_eye.jpg")

func travel_to_step(step_index: int) -> void:
	var step = GameManager.instance.get_step_at(step_index)
	update_diggable(step)
	super(step_index)
	
func connect_signal_handlers():
	pick.on_dig.connect(_handle_pick_hit)
	
# Mappings
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
			return 8
		Enums.STEP_TYPE.STONE:
			return 48
		Enums.STEP_TYPE.GOLD:
			return 24

func _get_intensity_damage(intensity: Enums.DIG_INTENSITY):
	match intensity:
		Enums.DIG_INTENSITY.LOW:
			return 1
		Enums.DIG_INTENSITY.MID:
			return 8
		Enums.DIG_INTENSITY.HIGH:
			return 16
