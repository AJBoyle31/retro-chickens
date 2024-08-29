extends Area2D
class_name HurtBox

var parent

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	parent = get_parent()


func connect_parent() -> void:
	parent.add_user_signal("damaged")
	
