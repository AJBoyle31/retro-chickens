extends Node2D
class_name EnemySpawner

const SNAKE := preload("res://scenes/npcs/snake.tscn")
const SCORPION := preload("res://scenes/npcs/scorpion.tscn")
const SNOWMAN := preload("res://scenes/npcs/snowman.tscn")

const ENEMY_OPTIONS: Array = [SNAKE, SCORPION, SNOWMAN]

var enemies: Array = [SNAKE, SCORPION, SNOWMAN]

func spawn_enemies() -> void:
	var enemy_spawn_points = get_children()
	for enemy_point in enemy_spawn_points:
		var new_enemy = ENEMY_OPTIONS[enemy_point.enemy_type].instantiate()
		new_enemy.global_position = enemy_point.global_position
		get_parent().get_node("Enemies").add_child(new_enemy)
		new_enemy.state = enemy_point.enemy_state
		new_enemy.direction = enemy_point.direction
		new_enemy.speed = enemy_point.speed
		
