extends Node

class_name BuffApplicationAgent

var buff_type: Buff
var modifiers: Dictionary[String, Variant]
var computed_description: String
var required_entities: Dictionary[String, Callable] # Callable returns entity
