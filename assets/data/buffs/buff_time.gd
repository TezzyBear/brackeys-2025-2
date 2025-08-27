extends Buff

#implement the functions
func activate() -> void:
	print("Activating buff: %s" % name_on_screen)

func deactivate() -> void:
	print("Deactivating buff: %s" % name_on_screen)
