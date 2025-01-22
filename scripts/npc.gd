extends Node2D
class_name NPC

@export_enum("idle", "walk") var state: String = "idle"
@export var speed: int = 30

var direction := 1

@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite
@onready var ray_cast_right: RayCast2D = %RayCastRight
@onready var ray_cast_left: RayCast2D = %RayCastLeft
@onready var npc_hitbox: Area2D = %NPCHitbox


func _ready() -> void:
	pass
	#animated_sprite.play(state)



func _process(_delta: float) -> void:
	pass

func idle(_delta) -> void:
	handle_facing_direction()

func walking(_delta) -> void:
	if ray_cast_left.is_colliding():
		direction = 1
	if ray_cast_right.is_colliding():
		direction = -1
	
	handle_facing_direction()
	
	position.x += speed * direction * _delta

func handle_facing_direction() -> void: 
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true


func kill_npc() -> void:
	queue_free()
