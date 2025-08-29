extends Panel

class_name UIDistance

@onready var label_distance: Label = $Value

func distance_show(distance: int) -> void:
	label_distance.text = str(distance)
