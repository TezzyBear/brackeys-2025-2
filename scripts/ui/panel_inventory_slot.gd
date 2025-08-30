extends TextureRect

class_name UIInventorySlot

@export var slot_id: int

var item: ActiveItemAgent = null

func place(item: ActiveItemAgent) -> bool:
	self.item = item
	texture = item.resource.icon_texure
	tooltip_text = item.resource.effect
	connect("gui_input", handle_gui_input)
	return true

func take() -> ActiveItemAgent:
	texture = null
	tooltip_text = ""
	var aux_item: ActiveItemAgent = item
	item = null
	return aux_item

func handle_gui_input(event: InputEvent) -> void:
	if event is not InputEventMouseButton:
		return
	if event.button_index != MOUSE_BUTTON_LEFT:
		return
	if !event.pressed:
		return
	
	if item.resource.consumable:
		item.consume()
	else:
		drop()
		
	GameManager.instance.item_delete(slot_id)
	
func drop() -> void:
	for buff in item.linked_buffs:
		GameManager.instance.remove_buff(buff)

func _on_item_mouse_entered() -> void:
	modulate = Color(1, 1, 1, 0.7)

func _on_item_mouse_exited() -> void:
	modulate = Color(1, 1, 1, 1)
