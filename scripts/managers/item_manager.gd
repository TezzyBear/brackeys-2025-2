extends Node

class_name ItemManager

var item_behaviours: Dictionary[ItemResource, Callable]

func initialize_behaviours() -> void:
	item_behaviours = {
		alchemists_stick_resource: AlchemistsStickBehaviour.behaviour.bind(GameManager.instance.dig_scene),
		glass_of_still_sands_resource: GlassOfStillSandsBehaviour.behaviour.bind(glass_of_still_sands_resource.buff_modifier_entries[0].buff),
		potion_of_rejuvenation_resource: PotionOfRejuvenationBehaviour.behaviour.bind(),
		potion_of_silence_resource: PotionOfSilenceBehaviour.behaviour.bind(GameManager.instance.sound_ui),
		whispering_plume_resource: WhisperingPlumeBehaviour.behaviour.bind(whispering_plume_resource.buff_modifier_entries[0]),
	}

func create_item_from_name(item_name: String) -> ActiveItemAgent:
	var created_item = ActiveItemAgent.new()
	created_item.resource = resource_by_name[item_name]
	if item_behaviours.has(created_item.resource):
		created_item.behaviour = item_behaviours[created_item.resource]
	return created_item

# Mappings
var alchemists_stick_resource: ItemResource = preload("res://assets/data/items/alchemists_stick.tres")
var cursed_runestone_resource = preload("res://assets/data/items/cursed_runestone.tres")
var glass_of_still_sands_resource: ItemResource = preload("res://assets/data/items/glass_of_still_sands.tres")
var iron_belt_sands_resource = preload("res://assets/data/items/iron_belt.tres")
var potion_of_rejuvenation_resource = preload("res://assets/data/items/potion_of_rejuvenation.tres")
var potion_of_silence_resource = preload("res://assets/data/items/potion_of_silence.tres")
var rune_of_might_resource = preload("res://assets/data/items/rune_of_might.tres")
var whispering_plume_resource = preload("res://assets/data/items/whispering_plume.tres")

var resource_by_name = {
	"Alchemist's Stick": alchemists_stick_resource,
	"Cursed Runestone": cursed_runestone_resource,
	"Glass of Still Sands": glass_of_still_sands_resource,
	"Iron Belt": iron_belt_sands_resource,
	"Potion of Rejuvenation": potion_of_rejuvenation_resource,
	"Potion of Silence": potion_of_silence_resource,
	"Rune of Might": rune_of_might_resource,
	"Whispering Plume": whispering_plume_resource
}
