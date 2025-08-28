extends Node

class_name BuffManager

var buffs: Array[Buff] = [
	load("res://assets/data/status_effects/feather_step_buff.tres"),
	load("res://assets/data/status_effects/heavy_debuff.tres"),
	load("res://assets/data/status_effects/stamina_buff.tres"),
	load("res://assets/data/status_effects/strength_buff.tres"),
	load("res://assets/data/status_effects/time_freeze_buff.tres")
]

func apply_buff(buff: Buff):
	buff.activate(buff_targets[buff].call())

# Mappings
var buff_targets = {
	buffs[0]: func(): return FatigueManager,
	buffs[1]: func(): return GameManager.instance.dig_scene,
	buffs[2]: func(): return FatigueManager,
	buffs[3]: func(): return GameManager.instance.dig_scene,
	buffs[4]: func(): return UITime
}
