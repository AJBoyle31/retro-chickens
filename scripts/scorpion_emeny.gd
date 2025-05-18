extends Enemy
class_name ScorpionEnemy


#specific to snake, general is covered under the super
func handle_facing_direction() -> void:
	super()
	if direction > 0:
		npc_hitbox.position = Vector2(-1,3)
		npc_hitbox.rotation = 46.4
		body_collision_shape_2d.position.x = 0
	elif direction < 0:
		npc_hitbox.position = Vector2(1,3)
		npc_hitbox.rotation = -46.4
		body_collision_shape_2d.position.x = 0
