extends Enemy

func _ready() -> void:
	pass
	#apply_gravity = true
	#can_attack = false
	#can_shoot = false
	#npc_bullet_speed = 0
	#attack_cooldown_time = 0.5

#specific to snake, general is covered under the super
func handle_facing_direction() -> void:
	super()
	if direction > 0:
		npc_hitbox.position.x = 1
		body_collision_shape_2d.position.x = 1
	elif direction < 0:
		npc_hitbox.position.x = -1
		body_collision_shape_2d.position.x = -1
