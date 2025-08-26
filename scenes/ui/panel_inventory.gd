extends Panel

class_name UIInventory

@export var items: Array[Item]
@onready var slots: Array[UIInventorySlot] = [$Slot,$Slot2,$Slot3,$Slot4,$Slot5]

func _ready() -> void:
	var item_dups: Array[Item] = []
	item_dups.resize(items.size())
	for i in range(items.size()):
		item_dups[i] = items[i].duplicate(true)
	inventory_place(item_dups)

func inventory_place(inventory: Array[Item]) -> void:
	for i in range(slots.size()):
		if i >= inventory.size():
			return
		if inventory[i] == null:
			return
		print("slot: ", slots[i]," & item: ", inventory[i])
		slots[i].place(inventory[i])
