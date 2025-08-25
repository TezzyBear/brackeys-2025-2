extends Node

var base: Array[Array] = [
		[Enums.STEP.DIRT, Enums.STEP.DIRT, Enums.STEP.DIRT],
		[Enums.STEP.DIRT, Enums.STEP.STONE, Enums.STEP.DIRT],
		[Enums.STEP.STONE, Enums.STEP.STONE, Enums.STEP.DIRT],
		[Enums.STEP.STONE, Enums.STEP.STONE, Enums.STEP.STONE],
	]
	
var gold: Array[Array] = [
		[Enums.STEP.GOLD, Enums.STEP.DIRT, Enums.STEP.GOLD],
		[Enums.STEP.GOLD, Enums.STEP.GOLD, Enums.STEP.DIRT],
		[Enums.STEP.GOLD, Enums.STEP.STONE, Enums.STEP.GOLD],
		[Enums.STEP.GOLD, Enums.STEP.GOLD, Enums.STEP.GOLD],
	]

func get_random_chunk(chunk_type: Enums.CHUNK_TYPES) -> Array:
	match chunk_type:
		Enums.CHUNK_TYPES.DIRT:
			return base[randi_range(0, base.size() - 1)] as Array[Enums.STEP]
		Enums.CHUNK_TYPES.GOLD:
			return gold[randi_range(0, gold.size() - 1)] as Array[Enums.STEP]
	return []
