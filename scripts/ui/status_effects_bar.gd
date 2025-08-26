extends Control

@onready var h_box_container: HBoxContainer = $HBoxContainer
const ICON_HEAVY_1 = preload("res://assets/images/icons/icon_heavy_1.jpg")
	
func add_status_effect_icon():
	var icon_texture_rect = TextureRect.new()
	icon_texture_rect.texture = ICON_HEAVY_1
	icon_texture_rect.expand_mode = TextureRect.EXPAND_FIT_WIDTH
	h_box_container.add_child(icon_texture_rect)
