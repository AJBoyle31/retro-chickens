#working on setting this up, need to add movement and animations stuff

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



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	pass

func idle(_delta) -> void:
	handle_facing_direction()

func walking(_delta) -> void:
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
