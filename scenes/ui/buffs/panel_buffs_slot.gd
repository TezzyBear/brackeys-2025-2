extends Control

class_name UIBuffsSlot

@onready var texture_rect_buff: TextureRect = $Buff

var _buff: Buff = null

func place(buff: Buff) -> bool:
	if _buff != null:
		return false
	_buff = buff
	_buff.activate()
	texture_rect_buff.texture = _buff.texture
	texture_rect_buff.tooltip_text = _buff.description
	texture_rect_buff.visible = true
	return true

func take() -> Buff:
	if _buff == null:
		return null
	texture_rect_buff.texture = null
	texture_rect_buff.tooltip_text = ""
	texture_rect_buff.visible = false
	var aux_item: Buff = _buff
	_buff.remove()
	_buff = null
	return aux_item
