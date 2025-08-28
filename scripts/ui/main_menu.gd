extends Node2D

@onready var btn_play: Button = $CanvasLayer/Play
@onready var btn_credits: Button = $CanvasLayer/Credits

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/credits.tscn")
