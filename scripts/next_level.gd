extends Area2D
class_name NextLevel

signal change_level(next_level)

@export var next_level: PackedScene

func _ready() -> void:
	if next_level == null:
		var level_parent = get_parent()
		print("Missing level on " + str(level_parent.name))
	get_tree()



func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		change_level.emit(next_level)
