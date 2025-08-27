extends Control

class_name TextCard

@export var type: Enums.CHUNK_TYPE
@export var title_text = "Title" #Maybe remove? I mean title should depend on type so...

@onready var title: Label = $Panel/Title

signal on_selected(type: Enums.CHUNK_TYPE)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	title.text = title_text

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	on_selected.emit(type)
