extends TextureRect

class_name UIBuffsSlot

var _buff: Buff = null

func place(buff: Buff) -> bool:
	if _buff != null:
		return false
	_buff = buff
	texture = _buff.texture
	tooltip_text = _buff.description
	#visible = true
	return true

func take() -> Buff:
	if _buff == null:
		return null
	texture = null
	tooltip_text = ""
	#visible = false
	var aux_item: Buff = _buff
	_buff = null
	return aux_item
