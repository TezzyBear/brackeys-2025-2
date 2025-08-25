extends Node

class_name SceneManager

func travel_to_step(current_step: Enums.STEP_TYPE) -> void:
	await GameManager.instance.transition_manager.fade_in()
