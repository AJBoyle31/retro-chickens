extends Node2D
class_name Game

var previous_level: Node2D
var current_level: Node2D

@onready var level_transition: LevelTransition = %LevelTransition

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.connect("change_level", _load_different_level)
	var children = get_children()
	for child in children:
		if child.name.begins_with("Level"):
			print(child.name)
			current_level = child 
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _load_different_level(next_level) -> void:
	level_transition.fade_level_out()
	await level_transition.animation_player.animation_finished
	current_level.queue_free()
	add_child(next_level)
	level_transition.fade_level_in()
	
