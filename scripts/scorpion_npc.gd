extends NPC


func _ready() -> void:
	print(state)
	#animated_sprite.play(state)

func _process(_delta: float) -> void:
	if state == "walk":
		walking(_delta)
	elif state == "idle":
		idle(_delta)


func handle_facing_direction() -> void:
	if direction > 0:
		animated_sprite.flip_h = false
		npc_hitbox.position.x = 0
	elif direction < 0:
		animated_sprite.flip_h = true
		npc_hitbox.position.x = -1
