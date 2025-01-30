extends NPCGravity

func handle_facing_direction() -> void:
	if direction > 0:
		collision_shape.position.x = 0
		npc_hitbox.position.x = 0
		animated_sprite.flip_h = false

	elif direction < 0:
		collision_shape.position.x = 3
		npc_hitbox.position.x = 3
		animated_sprite.flip_h = true
