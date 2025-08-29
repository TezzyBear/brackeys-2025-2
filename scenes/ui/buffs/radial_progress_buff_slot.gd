extends TextureProgressBar

class_name RadialProgressBuffSlot

var total_time: float
var time_so_far := 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_so_far += delta
	value = time_so_far / total_time * 100
	pass
