extends Area2D
class_name NextLevel

signal can_level_change

@export var next_level: PackedScene

func _ready() -> void:
	if next_level == null:
		var level_parent = get_parent()
		print("Missing level on " + str(level_parent.name))
	else:
		load(next_level.resource_path)



func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		can_level_change.emit()
		#SignalManager.change_level.emit(next_level)
