extends Panel

class_name UIBuffs

@onready var slots: Dictionary[ActiveBuffAgent, TextureProgressBar] = {}
@onready var h_box_container: HBoxContainer = $HBoxContainer

func place_buff(buff: ActiveBuffAgent) -> bool:
	if slots.size() > 3: 
		return false
		
	var buff_slot_scene: PackedScene = load("res://scenes/ui/buffs/radial_progress_buff_slot.tscn")
	var buff_slot: TextureProgressBar = buff_slot_scene.instantiate()

	buff_slot.total_time = buff.resource.duration
	buff_slot.texture_under = buff.resource.texture
	buff_slot.tooltip_text = buff.computed_description

	h_box_container.add_child(buff_slot)
	
	slots[buff] = buff_slot
	return true

func delete_buff(buff: ActiveBuffAgent):
	slots[buff].queue_free()
	slots.erase(buff)
