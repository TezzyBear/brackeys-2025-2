extends Node2D

class_name DigSceneManager

@onready var texture_rect: TextureRect = $CanvasGame/TextureRect
@onready var pick: Pick = $CanvasGame/Pick

const DIRT_TEXTURE = preload("res://assets/images/bgs/bg_dirt.jpg")
const STONE_TEXTURE = preload("res://assets/images/bgs/bg_stone.jpg")
const GOLD_TEXTURE = preload("res://assets/images/bgs/bg_gold.jpg")

func _ready() -> void:
	GameManager.instance.dig_scene = self
	var step_value = GameManager.instance.level_layout[GameManager.instance.level_index]
	texture_rect.texture = _get_diggable_texture(step_value)

func _process(delta: float) -> void:
	pass

func _get_diggable_texture(bg: Enums.STEP):
	match bg:
		Enums.STEP.DIRT:
			return DIRT_TEXTURE
		Enums.STEP.STONE:
			return STONE_TEXTURE
		Enums.STEP.GOLD:
			return GOLD_TEXTURE

func transition_to_bg(bg: Enums.STEP) -> void:
	await GameManager.instance.transition_manager.fade_out()
	texture_rect.texture = _get_diggable_texture(bg)
	await GameManager.instance.transition_manager.fade_in()
	
func transition_to_interaction(bg: Enums.STEP) -> void:
	await GameManager.instance.transition_manager.fade_out()
	GameManager.instance.dig_scene = null
	GameManager.instance.transition_to_scene(load("res://scenes/interaction.tscn"))
	
	
