extends CharacterBody2D
class_name Chicken

@export_enum("idle", "walk") var state: String = "idle"
@export var speed: int = 30


var gravity := 100
var direction := 1
var is_hit: bool = false
# Called when the node enters the scene tree for the first time.
@onready var animated_sprite = $AnimatedSprite
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_right: RayCast2D = $RayCastRight


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	
	if is_hit:
		animated_sprite.play("hit")
		velocity.x = 0
	else:
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
	
	handle_facing_direction(direction)
	move_and_slide()


func kill_npc() -> void:
	queue_free()

func handle_facing_direction(_direction) -> void: 
	if _direction > 0:
		animated_sprite.flip_h = false
	elif _direction < 0:
		animated_sprite.flip_h = true

func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area.has_method("destroy_bullet"):
		print("bullet hit")
		area.destroy_bullet()
		is_hit = true
