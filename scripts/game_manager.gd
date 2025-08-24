extends Node

var dig_scene: DigSceneManager = null

# Progress Variables
var level_index := -1
var level_layout := [] # Add predefined "routes" that end on an interaction

# Character Stats
var fatigue := 0 #cap 100
var weight := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("GameManager initialized...")
	
	var random_chunk = Chunks.return_chunk(Enums.CHUNK_TYPES.DIRT)
	level_layout.append(random_chunk)
	
	print(level_layout)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
