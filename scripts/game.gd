extends Node2D
class_name Game

@export var starting_level: PackedScene

var previous_level: Node2D
var current_level: Node2D

@onready var level_transition: LevelTransition = %LevelTransition

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.connect("change_level", _load_level)
	add_child(starting_level.instantiate())
	var children = get_children()
	for child in children:
		if child.name.begins_with("Level"):
			print(child.name)
			current_level = child 
	SignalManager.connect("restart_current_level", _reload_current_level)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

#This isn't working at all currently. 
func _reload_current_level() -> void:
	_load_level(current_level)
	

func _load_level(level_to_load) -> void:
	level_transition.fade_level_out()
	await level_transition.animation_player.animation_finished
	current_level.queue_free()
	add_child(level_to_load)
	current_level = level_to_load
	level_transition.fade_level_in()
	
