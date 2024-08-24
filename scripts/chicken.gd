extends CharacterBody2D
class_name Chicken

@export_enum("idle", "walk") var state: String = "idle"
@export var speed: int = 30

var gravity = 100
var direction = 1
# Called when the node enters the scene tree for the first time.
@onready var animated_sprite = $AnimatedSprite
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_right: RayCast2D = $RayCastRight


func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
		animated_sprite.play("walk")
	
	if state == "walk" and is_on_floor():
		velocity.x = direction * speed
		animated_sprite.play("walk")
	
	if state == "idle" and is_on_floor():
		velocity.x = 0
		animated_sprite.play("idle")
	
	if ray_cast_left.is_colliding():
		direction = 1
	
	if ray_cast_right.is_colliding():
		direction = -1
	
	move_and_slide()


func kill_npc() -> void:
	queue_free()
