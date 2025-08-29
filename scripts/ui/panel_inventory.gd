extends Panel

class_name UIInventory

@onready var slots: Array[UIInventorySlot] = [$Slot,$Slot2,$Slot3]

func place_item(item: ActiveItemAgent) -> bool:
	for i in range(slots.size()):
		print(i, slots[i].item)
		if slots[i].item == null:
			slots[i].place(item)
			return true
	return false

func delete_item(slot_id) -> bool:
	var aux_item: ActiveItemAgent = slots[slot_id].take()
	if aux_item != null:
		return true
	return false
