extends CharacterBody2D


@export var speed: int = 100
@export var jump_velocity: int = -225

enum States {IDLE, WALK, JUMP, HIT, SHOOT, DEAD}

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player_state: States = States.IDLE

@onready var player_sprite = $PlayerSprite
@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree
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
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
		handle_facing_direction(direction)
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	#Animations
	if is_on_floor():
		if Input.is_action_just_pressed("shoot"):
			if !direction:
				animation_state_machine.travel("shoot")
			shoot_gun()
		elif direction:
			animation_state_machine.travel("walk")
		else:
			animation_state_machine.travel("idle")
	else:
		animation_state_machine.travel("jump")
	
	move_and_slide()

func shoot_gun() -> void:
	pass

func handle_facing_direction(_direction) -> void: 
	if _direction > 0:
		player_sprite.flip_h = false
	elif _direction < 0:
		player_sprite.flip_h = true
