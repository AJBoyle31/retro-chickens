extends Area2D
class_name KillZone


@onready var timer: Timer = %Timer

func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()


func _on_body_entered(_body: Node2D) -> void:
	if _body.name == "Player":
		_body.player_died()
	if _body.has_method("chicken_has_died"):
		_body.chicken_has_died()
	if _body.has_method("kill_npc"):
		_body.kill_npc()

#Assuming for now the only area entering the killzone is a bullet
func _on_area_entered(_area: Area2D) -> void:
	_area.queue_free()
	
