extends AudioStreamPlayer2D

@export var streams: Array[AudioStream]

func on_dig(hit_intensiy: Enums.DIG_INTENSITY) -> void:
	match hit_intensiy:
		Enums.DIG_INTENSITY.LOW:
			stream = streams[Enums.DIG_INTENSITY.LOW]
		Enums.DIG_INTENSITY.MID:
			stream = streams[Enums.DIG_INTENSITY.MID]
		Enums.DIG_INTENSITY.HIGH:
			stream = streams[Enums.DIG_INTENSITY.HIGH]
	play(0.0)
