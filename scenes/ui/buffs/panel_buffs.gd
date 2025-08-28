extends Panel

class_name UIBuffs

@onready var slots: Array[UIBuffsSlot] = [
	$HBoxContainer/Slot,
	$HBoxContainer/Slot2,
	$HBoxContainer/Slot3
]

func place_buff(buff: Buff, slot_id: int) -> bool:
	var placed: bool = slots[slot_id].place(buff)
	return false

func delete_buff(slot_id) -> bool:
	var aux_item: Buff = slots[slot_id].take()
	if aux_item != null:
		return true
	return false
