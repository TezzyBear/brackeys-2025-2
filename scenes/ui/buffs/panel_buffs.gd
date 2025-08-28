extends Panel

class_name UIBuffs

@onready var slots: Array[UIBuffsSlot] = []
@onready var h_box_container: HBoxContainer = $HBoxContainer

func place_buff(buff: Buff, computed_description: String) -> bool:
	var buff_slot = UIBuffsSlot.new()
	buff_slot.place(buff)
	buff_slot.tooltip_text = computed_description
	h_box_container.add_child(buff_slot)
	
	slots.append(buff_slot)
	return false

func delete_buff(buff: Buff) -> bool:
	slots.erase(buff)
	var aux_item: Buff = buff
	if aux_item != null:
		return true
	return false
