extends Control

class_name TextCard

@export var type: Enums.CHUNK_TYPE
@export var texture_title:Texture2D
@export var texture_step:Texture2D

@onready var title: TextureRect = $Background/Title
@onready var step: TextureRect = $Background/Step

signal on_selected(type: Enums.CHUNK_TYPE)

func _ready() -> void:
	title.texture = texture_title
	step.texture = texture_step

func _on_button_pressed() -> void:
	on_selected.emit(type)
