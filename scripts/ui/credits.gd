extends Node2D

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("space") or Input.is_action_just_pressed("click"):
		get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
