extends TextureRect

class_name UIInventorySlot

@export var slot_id: int

var _item: Item = null

func place(item: Item) -> bool:
	if _item != null:
		return false
	_item = item
	texture = _item.texture
	tooltip_text = _item.effect
	return true

func take() -> Item:
	if _item == null:
		return null
	texture = null
	tooltip_text = ""
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
	print("using item ", _item.name)
	#code for using the item
	GameManager.instance.item_delete(slot_id)

func _on_item_mouse_entered() -> void:
	modulate = Color(1, 1, 1, 0.7)

func _on_item_mouse_exited() -> void:
	modulate = Color(1, 1, 1, 1)
