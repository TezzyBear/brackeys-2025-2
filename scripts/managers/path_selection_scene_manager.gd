extends InteractionSceneManager

class_name PathSelectionSceneManager

func _ready() -> void:
	GameManager.instance.interaction_scene = self
	for card in cards.get_children():
		card.on_selected.connect(transition_to_dig)

func travel_to_step(current_step: Enums.STEP_TYPE) -> void:
	super(current_step)
