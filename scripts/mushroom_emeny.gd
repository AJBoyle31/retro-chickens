extends Enemy

enum Mushroom_states {IDLE, EMERGE, EMERGED, SUBMERGE, ATTACK, HIT}
#if idle, then need to emerge and attack/shoot
#if player leaves detection area, then mushroom submerges and then goes to idle
var mushroom_state: Mushroom_states


func _ready() -> void:
	state = Enemy_state.IDLE
	mushroom_state = Mushroom_states.IDLE

func _physics_process(delta: float) -> void:
	pass
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

	#if Input.is_key_pressed(KEY_0):
		#state = "attack"
	#if Input.is_key_pressed(KEY_1):
		#state = "emerge"


func hit():
	animated_sprite.play("hit")
	if direction == 1:
		animated_sprite.flip_h = true
	elif direction == -1:
		animated_sprite.flip_h = false

func idle_state() -> void:
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
	else:
		mushroom_state = Mushroom_states.IDLE

#mushroom is rising from idle
func _emerging_state() -> void: 
	animated_sprite.play("emerge")
	in_cooldown = false
	npc_shot = false

#mushroom is at full attention
func _emerged_state() -> void:
	animated_sprite.play("emerged")
	npc_hitbox.show()
	#state = "attack"

#mushroom is returning to idle
func _submerging_state() -> void:
	npc_hitbox.hide()
	animated_sprite.play("submerge")


#specific to mushroom, general is covered under the super
func handle_facing_direction() -> void:
	super()
	if direction > 0:
		pass
	elif direction < 0:
		pass



#func _on_animated_sprite_animation_finished() -> void:
	##this is temporary for testing, mushroom doesn't need to always drop down before next shot
	#if animated_sprite.animation == "attack":
		#if player_detected:
			#state = "emerged"
			#cooldown_timer.start(cooldown_time)
			#in_cooldown = true
		#else:
			#state = "submerge"
	#
	#if animated_sprite.animation == "submerge":
		#state = "idle"
	#if animated_sprite.animation == "emerge":
		#state = "emerged"

func _on_player_detection_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		state = Enemy_state.ATTACK

func _on_player_detection_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		mushroom_state = Mushroom_states.IDLE


func _on_animated_sprite_animation_finished() -> void:
	if animated_sprite.animation == "attack":
		pass
	elif animated_sprite.animation == "submerge":
		mushroom_state = Mushroom_states.IDLE
	elif animated_sprite.animation == "emerge":
		mushroom_state = Mushroom_states.EMERGED
