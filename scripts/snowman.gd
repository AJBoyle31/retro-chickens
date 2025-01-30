extends NPCGravity
class_name Snowman

func handle_facing_direction() -> void:
	if direction > 0:
		collision_shape.position.x = 0
		npc_hitbox.position.x = 0
		animated_sprite.flip_h = false
		ray_cast_left.position.x = 0
	elif direction < 0:
		collision_shape.position.x = -2
		npc_hitbox.position.x = -2
		animated_sprite.flip_h = true
		ray_cast_left.position.x = -3
