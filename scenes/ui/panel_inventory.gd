extends Panel

class_name UIInventory

@onready var slots: Array[UIInventorySlot] = [$Slot,$Slot2,$Slot3,$Slot4,$Slot5]

func place_item(item: Item, slot_id: int) -> bool:
	var placed: bool = slots[slot_id].place(item)
	return false

func delete_item(slot_id) -> bool:
	var aux_item: Item = slots[slot_id].take()
	if aux_item != null:
		return true
	return false
