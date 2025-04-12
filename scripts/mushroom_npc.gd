extends NPC


func _ready() -> void:
	npc_hitbox.hide()
	#print(state)
	#animated_sprite.play(state)

func _process(_delta: float) -> void:
	if state == "walk":
		#walking(_delta)
		state = "idle"
	elif state == "idle":
		idle(_delta)


func _emerging_state() -> void: 
	pass

func _emerged_state() -> void:
	npc_hitbox.show()

func _submerging_state() -> void:
	npc_hitbox.hide()

func _shooting_state() -> void:
	pass

func handle_facing_direction() -> void:
	if direction > 0:
		animated_sprite.flip_h = false
		npc_hitbox.position.x = 0
	elif direction < 0:
		animated_sprite.flip_h = true
		npc_hitbox.position.x = -1
