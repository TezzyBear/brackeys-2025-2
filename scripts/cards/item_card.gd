extends Control

# TODO: Inheritance from Card - Not sure yet... Not enough overlap it seems like.
class_name ItemCard

var item: ItemResource

@onready var title: Label = $Panel/Title
@onready var description: Label = $Panel/Description
@onready var cost: Label = $Panel/Cost
@onready var texture_rect: TextureRect = $Panel/TextureRect
@onready var btn_purchase: Button = $Panel/Button

# TODO add price

signal on_purchased(item)

func update_item(item: ItemResource):
	self.item = item
	title.text = item.name
	description.text = item.description
	cost.text = str(item.cost)
	texture_rect.texture = item.texture
	texture_rect.tooltip_text = item.effect
	if GameManager.instance.gold >= item.cost:
		btn_purchase.disabled = false
	else:
		btn_purchase.disabled = true

func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	on_purchased.emit(item)
