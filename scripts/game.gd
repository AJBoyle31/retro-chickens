extends Node2D
class_name Game

@onready var level_transition: LevelTransition = %LevelTransition

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func load_different_level() -> void:
	level_transition.fade_level_out()
	#await level_transition.animation_player.animation_finished
	print("is it black?")
	
