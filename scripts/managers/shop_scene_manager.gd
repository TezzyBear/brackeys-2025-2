extends InteractionSceneManager

class_name ShopSceneManager

@export var items: Array[ItemResource]
@export var dialog_merchant: DialogCharacter
@onready var dialog_label_text: RichTextLabel = $CanvasInteractionDisplay/DialogCard/DialogText
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("dialog_merchant: ", dialog_merchant.first_interaction_active)
	_randomize_items()
	for card in cards.get_children():
		card.on_purchased.connect(_handle_item_purchased)
	_dialog_update()

func _dialog_update() -> void:
	if dialog_merchant.first_interaction_active:
		dialog_label_text.text = dialog_merchant.first_interaction
		dialog_merchant.first_interaction_active = false
		ResourceSaver.save(dialog_merchant, dialog_merchant.resource_path)
		return
	
	dialog_label_text.text = dialog_merchant.lines[randi_range(0, 1)]

func _randomize_items():
	var item_cards = cards.get_children()
	items.shuffle()
	var items_to_show = items.slice(0, 4)
	for i in items_to_show.size():
		(item_cards[i] as ItemCard).update_item(items_to_show[i]) 

func _handle_item_purchased(resource: ItemResource):
	var created_item := GameManager.instance.item_manager.create_item_from_name(resource.name)
	
	GameManager.instance.substract_gold(created_item.resource.cost)
	created_item.apply_item()
	var added: bool = GameManager.instance.add_item(created_item)
	if !added:
		printerr("item purchased, but not added to inventory")

	transition_to_dig()

func _process(delta: float) -> void:
	pass

func _on_exit_pressed() -> void:
	transition_to_dig()
