extends SceneManager

class_name InteractionSceneManager

@onready var cards: Control = $CanvasInteractionDisplay/Cards

var in_transition := false

func _ready() -> void:
	GameManager.instance.interaction_scene = self
	for card in cards.get_children():
		(card as SelectionCard).on_selected.connect(transition_to_dig)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func travel_to_step(current_step: Enums.STEP_TYPE) -> void:
	super(current_step)

func get_chunk_type_from_card_type(selected_card_type: Enums.CARD):
	match selected_card_type:
		Enums.CARD.DIRT_PATH:
			return Enums.CHUNK_TYPE.DIRT
		Enums.CARD.GOLD_PATH:
			return Enums.CHUNK_TYPE.GOLD

func transition_to_dig(selected_card_type: Enums.CARD) -> void:
	var next_chunk_type = get_chunk_type_from_card_type(selected_card_type)
	GameManager.instance.add_chunk(Chunks.get_random_chunk(next_chunk_type))
	GameManager.instance.interaction_scene = null
	GameManager.instance.run_step()
