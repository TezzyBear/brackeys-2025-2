extends Panel

class_name UIBackTo


func _on_back_to_merchant_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		#GameManager.instance.go_to_shop
		print("go to merchant")

func _on_back_to_home_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		#GameManager.instance.go_to_home
		print("go to home")
