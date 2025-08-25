extends Node

enum CHUNK_TYPES {
	DIRT,
	GOLD
}

enum STEP {
	# diggables
	DIRT,
	GOLD,
	STONE,
	# 3+ means interaction (non-diggables)
	STORE,
	SELECTION,
	ENCOUNTER,
	TREASURE,
}

# Add risk factor by adding sneaky enemies/characters that will say truth or not to a path

enum CARD {
	GOLD_PATH,
	DIRT_PATH,
}
