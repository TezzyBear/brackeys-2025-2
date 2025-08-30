extends InteractionSceneManager

class_name PathSelectionSceneManager

@export var dialog_dwarf: DialogCharacter
@onready var dialog_label_text: RichTextLabel = $CanvasInteractionDisplay/DialogCard/DialogText

func _ready() -> void:
	GameManager.instance.interaction_scene = self
	for card in cards.get_children():
		card.on_selected.connect(transition_to_dig)
	_dialog_update()

func _dialog_update() -> void:
	print("dwarf first: ", dialog_dwarf.first_interaction_active, dialog_dwarf.first_interaction)
	if dialog_dwarf.first_interaction_active:
		dialog_label_text.text = dialog_dwarf.first_interaction
		dialog_dwarf.first_interaction_active = false
		ResourceSaver.save(dialog_dwarf, dialog_dwarf.resource_path)
		return
	
	dialog_label_text.text = dialog_dwarf.lines[randi_range(0, 2)]

func travel_to_step(current_step: Enums.STEP_TYPE) -> void:
	super(current_step)
