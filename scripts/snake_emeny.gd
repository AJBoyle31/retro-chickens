extends Enemy
class_name SnakeEnemy




#specific to snake, general is covered under the super
func handle_facing_direction() -> void:
	super()
	if direction > 0:
		body_collision_shape_2d.position.x = 0
		npc_hitbox.position.x = 0
	elif direction < 0:
		body_collision_shape_2d.position.x = 3
		npc_hitbox.position.x = 3
