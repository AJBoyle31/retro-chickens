extends Enemy

enum Mushroom_states {IDLE, EMERGE, EMERGED, SUBMERGE, ATTACK, HIT}
#if idle, then need to emerge and attack/shoot
#if player leaves detection area, then mushroom submerges and then goes to idle
var mushroom_state: Mushroom_states


@onready var player_detection_area: Area2D = %PlayerDetectionArea



func _ready() -> void:
	state = Enemy_state.IDLE
	mushroom_state = Mushroom_states.IDLE
	npc_hitbox.hide()


func _physics_process(_delta: float) -> void:
	if !is_on_floor(): 
		velocity.y += 10
		move_and_slide()
	match mushroom_state:
		Mushroom_states.IDLE:
			idle_state()
		Mushroom_states.EMERGE:
			_emerging_state()
		Mushroom_states.EMERGED:
			_emerged_state()
		Mushroom_states.SUBMERGE:
			_submerging_state()
		Mushroom_states.ATTACK:
			attack_state()
		Mushroom_states.HIT:
			hit_state()

	if Input.is_key_pressed(KEY_0) and mushroom_state != Mushroom_states.EMERGED:
		mushroom_state = Mushroom_states.EMERGE
	if Input.is_key_pressed(KEY_1) and mushroom_state == Mushroom_states.EMERGED:
		mushroom_state = Mushroom_states.SUBMERGE
	if Input.is_key_pressed(KEY_2) and mushroom_state == Mushroom_states.EMERGED:
		mushroom_state = Mushroom_states.ATTACK
	
	handle_facing_direction()



func hit():
	animated_sprite.play("hit")
	if direction == 1:
		animated_sprite.flip_h = true
	elif direction == -1:
		animated_sprite.flip_h = false

func idle_state() -> void:
	if player_detected:
		if animated_sprite.animation == "idle" or animated_sprite.animation == "submerge":
			mushroom_state = Mushroom_states.EMERGE
	else:
		if animated_sprite.animation == "emerged":
			mushroom_state = Mushroom_states.SUBMERGE
		else:
			animated_sprite.play("idle")


func walking_state(_delta) -> void: 
	mushroom_state = Mushroom_states.IDLE

func attack_state() -> void:
	if can_attack:
		animated_sprite.play("attack")
		if can_shoot:
			if !npc_shot:
				npc_shot = true
				shoot_bullet()
			else:
				pass


#mushroom is rising from idle
func _emerging_state() -> void: 
	animated_sprite.play("emerge")
	in_cooldown = false
	npc_shot = false

#mushroom is at full attention
func _emerged_state() -> void:
	animated_sprite.play("emerged")
	#npc_hitbox.show()
	if player_detected:
		mushroom_state = Mushroom_states.ATTACK
	else:
		mushroom_state = Mushroom_states.SUBMERGE


#mushroom is returning to idle
func _submerging_state() -> void:
	#npc_hitbox.hide()
	animated_sprite.play("submerge")


#specific to mushroom, general is covered under the super
func handle_facing_direction() -> void:
	super()
	if direction > 0:
		player_detection_area.rotation_degrees = 180.0
	elif direction < 0:
		player_detection_area.rotation_degrees = 0


func _on_player_detection_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_detected = true
		if animated_sprite.animation == "idle":
			mushroom_state = Mushroom_states.EMERGE
		elif animated_sprite.animation == "emerged":
			mushroom_state = Mushroom_states.ATTACK

func _on_player_detection_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_detected = false
		if animated_sprite.animation == "emerged":
			mushroom_state = Mushroom_states.SUBMERGE


func _on_animated_sprite_animation_finished() -> void:
	if animated_sprite.animation == "attack":
		mushroom_state = Mushroom_states.EMERGED
	elif animated_sprite.animation == "submerge":
		mushroom_state = Mushroom_states.IDLE
	elif animated_sprite.animation == "emerge":
		mushroom_state = Mushroom_states.EMERGED
