extends Control

# TODO: Inheritance from Card
class_name ItemCard

@export var item: Item

@onready var title: Label = $Panel/Title
@onready var description: Label = $Panel/Description
@onready var texture_rect: TextureRect = $Panel/TextureRect

signal on_purchased(type: Item)

func _ready() -> void:
	title.text = item.name
	description.text = item.description
	texture_rect.texture = item.texture

func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	on_purchased.emit(item)
