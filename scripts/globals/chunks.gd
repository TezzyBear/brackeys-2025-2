extends Node

var dirt_step: Step = Step.create(Enums.STEP_TYPE.DIRT, true)
var stone_step: Step = Step.create(Enums.STEP_TYPE.STONE, true)
var gold_step: Step = Step.create(Enums.STEP_TYPE.GOLD, true)
var shop_step: Step = Step.create(Enums.STEP_TYPE.SHOP, false)
var path_selection_step: Step = Step.create(Enums.STEP_TYPE.PATH_SELECTION, false)

var base: Array[Array] = [
		[dirt_step, dirt_step, dirt_step],
		[dirt_step, stone_step, dirt_step],
		[stone_step, stone_step, dirt_step],
		[stone_step, stone_step, stone_step],
	]
	
var gold: Array[Array] = [
		[gold_step, dirt_step, gold_step],
		[gold_step, gold_step, dirt_step],
		[gold_step, stone_step, gold_step],
		[gold_step, gold_step, gold_step],
	]

func get_random_chunk(chunk_type: Enums.CHUNK_TYPE) -> Array:
	match chunk_type:
		Enums.CHUNK_TYPE.DIRT:
			return base[randi_range(0, base.size() - 1)]
		Enums.CHUNK_TYPE.GOLD:
			return gold[randi_range(0, gold.size() - 1)]
	return []
