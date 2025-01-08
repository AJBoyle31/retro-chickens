extends CharacterBody2D
class_name Player

signal shoot(bullet)
signal player_has_died

const BULLET = preload("res://scenes/player/bullet.tscn")

@export var speed: int = 80
@export var acceleration: int = 150
@export var friction: int = 400
@export var jump_velocity: int = -225


enum States {IDLE, WALK, JUMP, HIT, SHOOT, DEAD}

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player_state: States = States.IDLE
var bullet_count: int
var player_hit_by_npc: bool = false
var player_alive: bool = true
var player_facing_direction: int = 1

@onready var player_sprite: Sprite2D = %PlayerSprite
@onready var player_hitbox: HurtBox = %HurtBox
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var animation_tree: AnimationTree = %AnimationTree
@onready var animation_state_machine = animation_tree["parameters/playback"]
@onready var player_world_collision_shape: CollisionShape2D = %WorldCollisionShape

func _ready() -> void:
	player_alive = true

func _physics_process(delta) -> void:
	if player_alive:
		
		if not is_on_floor():
			velocity.y += gravity * delta
			player_state = States.JUMP

		# Handle jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = jump_velocity
			player_state = States.JUMP
		
		var direction = Input.get_axis("move_left", "move_right")
		if direction:
			velocity.x = move_toward(velocity.x, direction * speed, acceleration * delta)
			handle_facing_direction(direction)
		else:
			velocity.x = move_toward(velocity.x, 0, friction * delta)
		
		#Animations
		if player_hit_by_npc:
			animation_state_machine.travel("hit")
			player_state = States.HIT
			player_alive = false
		elif is_on_floor():
			#Can't shoot if you are not on the ground
			if Input.is_action_just_pressed("shoot") and bullet_count > 0:
				player_state = States.SHOOT
				if !direction:
					animation_state_machine.travel("shoot")
				else: 
					shoot_gun()
			elif direction:
				animation_state_machine.travel("walk")
				player_state = States.WALK
			else:
				animation_state_machine.travel("idle")
				player_state = States.IDLE
		else:
			animation_state_machine.travel("jump")
			player_state = States.JUMP
		
		move_and_slide()
		

func shoot_gun() -> void:
	shoot.emit(BULLET)


func handle_facing_direction(_direction: int) -> void: 
	if _direction > 0:
		player_sprite.flip_h = false
		player_hitbox.position.x = 0
		player_world_collision_shape.position.x = -1
		player_facing_direction = 1
	elif _direction < 0:
		player_sprite.flip_h = true
		player_hitbox.position.x = 2
		player_world_collision_shape.position.x = 1
		player_facing_direction = -1

func set_bullet_count(_bullet_count: int) -> void:
	bullet_count = _bullet_count

func _on_hurt_box_area_entered(area: Area2D) -> void:
	print(area.name)
	if area.name.contains("NPC"):
		print("You've been snake bit")
		player_hit_by_npc = true
		player_state = States.HIT
		

func disable_player() -> void:
	set_physics_process(false)
	set_process_input(false)

func enable_player() -> void:
	set_physics_process(true)
	set_process_input(true)

func player_died() -> void:
	player_state = States.DEAD
	emit_signal("player_has_died")
	queue_free()
