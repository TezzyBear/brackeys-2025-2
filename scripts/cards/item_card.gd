extends Control

# TODO: Inheritance from Card - Not sure yet... Not enough overlap it seems like.
class_name ItemCard

var item: ItemResource

@onready var background: TextureRect = $Background
@onready var title: TextureRect = $Background/Title
@onready var description: RichTextLabel = $Background/Description
@onready var cost: Label = $Background/Cost
@onready var btn_purchase: Button = $Panel/Button

# TODO add price

signal on_purchased(item)

func update_item(item: ItemResource):
	self.item = item
	background.texture = item.texture_bg
	title.texture = item.texture_name
	description.text = item.description
	cost.text = str(item.cost)
	background.tooltip_text = item.effect
	if GameManager.instance.gold >= item.cost:
		btn_purchase.disabled = false
	else:
		btn_purchase.disabled = true

func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	on_purchased.emit(item)
