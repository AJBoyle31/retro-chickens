extends Area2D
class_name Bullets

var speed: int = 100
var direction: int = 1

func _process(delta: float) -> void:
	position.x += speed * delta * direction

func destroy_bullet() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.name == "World":
		print(body.name)
		destroy_bullet()
