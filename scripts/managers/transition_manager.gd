extends Node

class_name TransitionManager
@onready var overlay: Overlay = $"../CanvasOverlay"

var in_transition := false

func fade_in():
	in_transition = true
	await overlay.fade_in()
	in_transition = false
	
func fade_out():
	in_transition = true
	await overlay.fade_out()
	in_transition = false
