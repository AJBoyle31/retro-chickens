extends Area2D
class_name Bullets


var direction: int = 1

func _process(delta: float) -> void:
	position.x += 250 * delta * direction

func destroy_bullet() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.name == "World":
		destroy_bullet()
