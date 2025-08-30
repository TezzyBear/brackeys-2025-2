extends Node

enum CHUNK_TYPE {
	DIRT,
	GOLD
}

enum STEP_TYPE {
	# diggables
	DIRT,
	GOLD,
	STONE,
	OBSIDIAN,
	# 3+ means interaction (non-diggables)
	SHOP,
	PATH_SELECTION,
	TREASURE,
}

# Add risk factor by adding sneaky enemies/characters that will say truth or not to a path

enum DIG_INTENSITY {
	LOW,
	MID,
	HIGH
}

enum RARITY {
	COMMON,
	RARE
}
