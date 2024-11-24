extends CharacterBody2D
class_name NPCGravity

@export_enum("idle", "walk") var state: String = "idle"
@export var speed: int = 30

var direction := 1
var gravity := 100

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var npc_hitbox: Area2D = $NPCHitbox


func _ready() -> void:
	pass 


func _physics_process(_delta: float) -> void:
	if state == "walk" and is_on_floor():
		walking(_delta)
	if state == "idle" and is_on_floor():
		idle(_delta)
	
	move_and_slide()

func idle(_delta) -> void:
	velocity.x = 0
	animated_sprite.play("idle")
	handle_facing_direction()

func walking(_delta) -> void:
	velocity.x = direction * speed
	animated_sprite.play("walk")
	if ray_cast_left.is_colliding():
		direction = 1
	if ray_cast_right.is_colliding():
		direction = -1
	
	handle_facing_direction()

func handle_facing_direction() -> void: 
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
