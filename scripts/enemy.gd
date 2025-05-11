extends CharacterBody2D
class_name Enemy

signal npc_shoot(bullet, position, direction, speed)

enum Enemy_state {IDLE, WALK, ATTACK, HIT}

@export var state: Enemy_state = Enemy_state.IDLE
@export var apply_gravity: bool = true
@export var can_attack: bool = false
@export var can_shoot: bool = false
@export var npc_bullet_speed: int = 75
@export var attack_cooldown_time: float = 0.5
@export var speed: int = 30

const BULLET = preload("res://scenes/npcs/npc_bullet.tscn")

#MOVEMENT
var direction := 1
var gravity := 100

#ATTACK/BULLET 
var player_detected: bool = false
var in_cooldown: bool = false
var npc_shot: bool = false
var cooldown_time: float = 0.5

@onready var body_collision_shape_2d: CollisionShape2D = %BodyCollisionShape2D
@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite
@onready var ray_cast_right: RayCast2D = %RayCastRight
@onready var ray_cast_left: RayCast2D = %RayCastLeft
@onready var npc_hitbox: Area2D = %NPCHitbox
@onready var cooldown_timer: Timer = %CooldownTimer

func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
	#MOVEMENT
	#if not is_on_floor() and apply_gravity:
		#velocity.y += gravity * _delta
	#elif state == Enemy_state.WALK and is_on_floor():
		#velocity.x = direction * speed
	#elif state == Enemy_state.IDLE and is_on_floor():
		#velocity.x = 0
	
	match state:
		Enemy_state.IDLE:
			idle_state()
		Enemy_state.WALK:
			walking_state(_delta)
		Enemy_state.ATTACK:
			attack_state()
		Enemy_state.HIT:
			hit_state()
		_:
			idle_state()
	
	#COLLISIONS WITH THE WORLD
	if ray_cast_left.is_colliding():
		direction = 1
	if ray_cast_right.is_colliding():
		direction = -1
	
	handle_facing_direction()
	movement(_delta)

#ENEMY MOVEMENT
func movement(_delta) -> void:
	if not is_on_floor() and apply_gravity:
		velocity.y += gravity * _delta
	move_and_slide()

#ENEMY IDLE STATE
func idle_state() -> void:
	if is_on_floor():
		velocity.x = 0
	animated_sprite.play("idle")
	handle_facing_direction()

#ENEMY WALKING STATE
func walking_state(_delta) -> void:
	velocity.x = direction * speed
	animated_sprite.play("walk")
	if ray_cast_left.is_colliding():
		direction = 1
	if ray_cast_right.is_colliding():
		direction = -1
	
	handle_facing_direction()

#ENEMY ATTACK STATE
func attack_state() -> void:
	if can_attack:
		animated_sprite.play("attack")
		if can_shoot:
			if !npc_shot:
				shoot_bullet()
				npc_shot = true
			else:
				pass
	else:
		state = Enemy_state.IDLE

#ENEMYS THAT CAN SHOOT BULLETS
func shoot_bullet():
	npc_shoot.emit(BULLET, global_position, direction, npc_bullet_speed)

#ENEMIES THAT ARE HIT BY PLAYER BULLETS
func hit_state() -> void:
	animated_sprite.play("hit")

#ADJUSTS ENEMY FACING DIRECTION
func handle_facing_direction() -> void: 
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

#ENEMY IS DEAD
func kill_npc() -> void:
	queue_free()

#ENEMY IS HIT BY A PLAYER BULLET
func _on_npc_hitbox_area_entered(area: Area2D) -> void:
	if area.name.contains("PlayerBullet"):
		print("PLAYER BULLET HIT!")
		if area.has_method("destroy_bullet"):
			area.destroy_bullet()
