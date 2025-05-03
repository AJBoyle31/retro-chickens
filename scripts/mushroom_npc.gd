extends NPC

#emerges and shoots a bullet
#no hit box while in ground
#waits for player to get close or walk past to emerge and shoot
#adjust the emerging speed to make it more difficult

signal npc_shoot(bullet, position, direction)

const BULLET = preload("res://scenes/npcs/npc_bullet.tscn")

var in_cooldown: bool = false
var npc_shot: bool = false
var cooldown_time: float = 0.5
var player_detected: bool = false

@onready var player_detection_collision_shape: CollisionShape2D = %PlayerDetectionCollisionShape
@onready var cooldown_timer: Timer = %CooldownTimer


func _ready() -> void:
	npc_hitbox.hide()
	state = "idle"
	#print(state)
	#animated_sprite.play(state)

func _process(_delta: float) -> void:
	match state:
		"walk":
			idle(_delta)
		"idle":
			idle(_delta)
		"emerge":
			_emerging_state()
		"emerged":
			_emerged_state()
		"submerge":
			_submerging_state()
		"attack":
			if !in_cooldown:
				_attack_state()
			else:
				_emerged_state()

	if Input.is_key_pressed(KEY_0):
		state = "attack"
	if Input.is_key_pressed(KEY_1):
		state = "emerge"


#mushroom is shooting his shot
func _attack_state() -> void:
	animated_sprite.play("attack")
	if !npc_shot:
		shoot_bullet()
		npc_shot = true
	else:
		pass


#mushroom is rising from idle
func _emerging_state() -> void: 
	animated_sprite.play("emerge")

#mushroom is at full attention
func _emerged_state() -> void:
	animated_sprite.play("emerged")
	npc_hitbox.show()
	state = "attack"

#mushroom is returning to idle
func _submerging_state() -> void:
	npc_hitbox.hide()
	animated_sprite.play("submerge")

func shoot_bullet():
	npc_shoot.emit(BULLET, global_position, direction)

func handle_facing_direction() -> void:
	if direction > 0:
		animated_sprite.flip_h = false
		npc_hitbox.position.x = 0
		player_detection_collision_shape.position = Vector2(33,2)
	elif direction < 0:
		animated_sprite.flip_h = true
		npc_hitbox.position.x = -1
		player_detection_collision_shape.position = Vector2(-33,2)


func _on_animated_sprite_animation_finished() -> void:
	#this is temporary for testing, mushroom doesn't need to always drop down before next shot
	if animated_sprite.animation == "attack":
		if player_detected:
			state = "emerged"
			cooldown_timer.start(cooldown_time)
			in_cooldown = true
		else:
			state = "submerge"
	
	if animated_sprite.animation == "submerge":
		state = "idle"
	if animated_sprite.animation == "emerge":
		state = "emerged"


func _on_cooldown_timer_timeout() -> void:
	in_cooldown = false
	npc_shot = false


func _on_player_detection_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_detected = true
		if state == "emerged":
			state = "attack"
		elif state == "idle":
			state = "emerge"
	else:
		pass


func _on_player_detection_area_body_exited(body: Node2D) -> void:
	player_detected = false
