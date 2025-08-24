extends Node

var base: Array[Array] = [
		[Enums.DIGGABLE.DIRT, Enums.DIGGABLE.DIRT, Enums.DIGGABLE.DIRT],
		[Enums.DIGGABLE.DIRT, Enums.DIGGABLE.STONE, Enums.DIGGABLE.DIRT],
		[Enums.DIGGABLE.STONE, Enums.DIGGABLE.STONE, Enums.DIGGABLE.DIRT],
		[Enums.DIGGABLE.STONE, Enums.DIGGABLE.STONE, Enums.DIGGABLE.STONE],
	]
	
var gold: Array[Array] = [
		[Enums.DIGGABLE.GOLD, Enums.DIGGABLE.DIRT, Enums.DIGGABLE.GOLD],
		[Enums.DIGGABLE.GOLD, Enums.DIGGABLE.GOLD, Enums.DIGGABLE.DIRT],
		[Enums.DIGGABLE.GOLD, Enums.DIGGABLE.STONE, Enums.DIGGABLE.GOLD],
		[Enums.DIGGABLE.GOLD, Enums.DIGGABLE.GOLD, Enums.DIGGABLE.GOLD],
	]

func return_chunk(chunk_type: Enums.CHUNK_TYPES) -> Array:
	match chunk_type:
		Enums.CHUNK_TYPES.DIRT:
			return base[randi_range(0, base.size() - 1)] as Array[Enums.DIGGABLE]
		Enums.CHUNK_TYPES.GOLD:
			return gold[randi_range(0, gold.size() - 1)] as Array[Enums.DIGGABLE]
	return []
		
