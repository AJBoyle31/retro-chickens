extends Area2D


@onready var timer = $Timer

func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()


func _on_body_entered(_body: Node2D) -> void:
	if _body.name == "Player":
		timer.start()
	if _body.name.contains("Chicken"):
		_body.kill_npc()