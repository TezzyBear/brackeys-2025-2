extends AudioStreamPlayer2D

@export var streams: Array[AudioStream]

func on_step_end(step_type: Enums.STEP_TYPE) -> void:
	match step_type:
		Enums.STEP_TYPE.DIRT:
			stream = streams[Enums.STEP_TYPE.DIRT]
		Enums.STEP_TYPE.GOLD:
			stream = streams[Enums.STEP_TYPE.GOLD]
		Enums.STEP_TYPE.STONE:
			stream = streams[Enums.STEP_TYPE.STONE]
	play(0.0)
