extends Area2D
class_name Bullets

var speed: int = 100
var direction: int

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	position.x += speed * delta * direction
	

func destroy_bullet() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.name == "World":
		destroy_bullet()
	elif body.name == "Player":
		destroy_bullet()

func _on_area_entered(_area: Area2D) -> void:
	pass
