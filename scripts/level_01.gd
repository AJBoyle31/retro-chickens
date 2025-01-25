extends Level

@onready var chicken_2: Chicken = $Chickens/Chicken2



func _on_chicken_start_moving_body_entered(_body: Node2D) -> void:
	if _body.name == "Player":
		chicken_2.state = "walk"


func _on_chicken_chicken_collected(_was_chicken_collected: bool) -> void:
	update_chicken_count(true)


func _on_chicken_3_chicken_collected(_was_chicken_collected: bool) -> void:
	update_chicken_count(true)


func _on_chicken_2_chicken_collected(_was_chicken_collected: bool) -> void:
	update_chicken_count(true)
