extends InteractionSceneManager

class_name ShopSceneManager

@export var items: Array[Item]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_randomize_items()
	for card in cards.get_children():
		card.on_purchased.connect(_handle_item_purchased)

func _randomize_items():
	var item_cards = (cards.get_children() as Array[ItemCard])
	items.shuffle()
	var items_to_show = items.slice(0, 4)
	for i in items_to_show.size():
		item_cards[i].update_item(items_to_show[i]) 

func _handle_item_purchased(item: Item):
	var duplicated_item = item.duplicate(true) as Item
	duplicated_item.apply_item()
	GameManager.instance.add_item(duplicated_item)
	transition_to_dig()

func _process(delta: float) -> void:
	pass
