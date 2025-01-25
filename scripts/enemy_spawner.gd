extends Node2D
class_name EnemySpawner

const SNAKE := preload("res://scenes/npcs/snake_npc.tscn")
const SCORPION := preload("res://scenes/npcs/scorpion_npc.tscn")

const ENEMY_OPTIONS: Array = [SNAKE, SCORPION]

var enemies: Array = [SNAKE, SCORPION]

func spawn_enemies() -> void:
	var enemy_spawn_points = get_children()
	for enemy_point in enemy_spawn_points:
		var new_enemy = ENEMY_OPTIONS[enemy_point.enemy_type].instantiate()
		new_enemy.global_position = enemy_point.global_position
		get_parent().get_node("Enemies").add_child(new_enemy)
		new_enemy.state = enemy_point.state
		new_enemy.direction = enemy_point.direction
		print(new_enemy.direction)
		new_enemy.speed = enemy_point.speed
		
