extends CharacterBody2D
class_name Player

const BULLET = preload("res://scenes/player/bullet.tscn")

@export var speed: int = 100
@export var jump_velocity: int = -225
@export var bullet_count: int = 5

enum States {IDLE, WALK, JUMP, HIT, SHOOT, DEAD}

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player_state: States = States.IDLE

@onready var player_sprite: = $PlayerSprite
@onready var player_world_collision_shape: = $WorldCollisionShape
@onready var player_hitbox: = $HurtBox
@onready var animation_player: = $AnimationPlayer
@onready var animation_tree: = $AnimationTree
@onready var animation_state_machine = animation_tree["parameters/playback"]


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		player_state = States.JUMP

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
		player_state = States.JUMP
	
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
		handle_facing_direction(direction)
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	#Animations
	if is_on_floor():
		#Can't shoot if you are not on the ground
		if Input.is_action_just_pressed("shoot") and bullet_count > 0:
			if !direction:
				animation_state_machine.travel("shoot")
			else: 
				shoot_gun()
		elif direction:
			animation_state_machine.travel("walk")
		else:
			animation_state_machine.travel("idle")
	else:
		animation_state_machine.travel("jump")
	
	move_and_slide()

func shoot_gun() -> void:
	bullet_count -= 1
	var bullet_instance = BULLET.instantiate()
	get_parent().add_child(bullet_instance)
	bullet_instance.global_position = global_position
	if !player_sprite.flip_h:
		bullet_instance.direction = 1
		bullet_instance.global_position.x += 10
	else:
		bullet_instance.direction = -1
		bullet_instance.global_position.x -= 2

func handle_facing_direction(_direction) -> void: 
	if _direction > 0:
		player_sprite.flip_h = false
		player_hitbox.position.x = 0
		player_world_collision_shape.position.x = -1
	elif _direction < 0:
		player_sprite.flip_h = true
		player_hitbox.position.x = 2
		player_world_collision_shape.position.x = 1
