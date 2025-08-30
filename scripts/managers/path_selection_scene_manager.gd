extends InteractionSceneManager

class_name PathSelectionSceneManager

@onready var dialog_label_text: RichTextLabel = $CanvasInteractionDisplay/DialogCard/DialogText

func _ready() -> void:
	print("dwarf first: ", GameManager.instance.dialog_dwarf.first_interaction_active, GameManager.instance.dialog_dwarf.first_interaction)
	GameManager.instance.interaction_scene = self
	for card in cards.get_children():
		card.on_selected.connect(transition_to_dig)
	_dialog_update()

func _dialog_update() -> void:
	if GameManager.instance.dialog_dwarf.first_interaction_active:
		dialog_label_text.text = GameManager.instance.dialog_dwarf.first_interaction
		GameManager.instance.dialog_dwarf.first_interaction_active = false
		return
	
	dialog_label_text.text = GameManager.instance.dialog_dwarf.lines[randi_range(0, 2)]

func travel_to_step(current_step: Enums.STEP_TYPE) -> void:
	super(current_step)
