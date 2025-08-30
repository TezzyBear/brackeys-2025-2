extends Node

class_name FeatherStepBuffBehaviour

static func behaviour(modifier, sound_ui: UISound):
	sound_ui.noise_multiplier = modifier / 100.0

static func remove(modifier, sound_ui: UISound):
	sound_ui.noise_multiplier = 1.0
