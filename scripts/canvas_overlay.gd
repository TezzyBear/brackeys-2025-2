extends CanvasLayer

class_name Overlay

@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func fade_out():
	animation_player.play("fade_out")
	await animation_player.animation_finished

func fade_in():
	animation_player.play("fade_in")
	await animation_player.animation_finished
