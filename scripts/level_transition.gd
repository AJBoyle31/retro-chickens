extends Control
class_name LevelTransition


@onready var animation_player: AnimationPlayer = %AnimationPlayer


func fade_level_out() -> void:
	animation_player.play("fade_out")
	

func fade_level_in() -> void: 
	animation_player.play("fade_in")
