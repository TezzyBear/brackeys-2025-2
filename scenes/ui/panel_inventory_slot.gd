extends Control

class_name UIInventorySlot

@onready var texture_rect_border: TextureRect = $Border
@onready var texture_rect_item: TextureRect = $Item

var _item: Item = null

func place(item: Item) -> bool:
	if _item != null:
		return false
	_item = item
	texture_rect_item.texture = _item.texture
	texture_rect_item.tooltip_text = _item.description
	texture_rect_item.visible = true
	return true

func take() -> Item:
	if _item == null:
		return null
	texture_rect_item.texture = null
	texture_rect_item.tooltip_text = ""
	texture_rect_item.visible = false
	var aux_item: Item = _item
	_item = null
	return aux_item

func use(event: InputEvent) -> void:
	if event is not InputEventMouseButton:
		return
	if event.button_index != MOUSE_BUTTON_LEFT:
		return
	if !event.pressed:
		return
	#code for using the item
	#code for telling the game_manager we've used the itemx
	print("using item ", _item.name_on_screen)
	take()
	pass

func _on_item_mouse_entered() -> void:
	texture_rect_item.modulate = Color(1, 1, 1, 0.7)

func _on_item_mouse_exited() -> void:
	texture_rect_item.modulate = Color(1, 1, 1, 1)
