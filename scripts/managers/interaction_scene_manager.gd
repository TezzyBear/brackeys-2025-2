extends SceneManager

class_name InteractionSceneManager

@export var cards: Control

func _ready() -> void:
	GameManager.instance.interaction_scene = self

func travel_to_step(current_step: Enums.STEP_TYPE) -> void:
	super(current_step)

func transition_to_dig(next_chunk := Enums.CHUNK_TYPE.DIRT) -> void:
	GameManager.instance.add_chunk(Chunks.get_random_chunk(next_chunk))
	GameManager.instance.interaction_scene = null
	GameManager.instance.run_step()
