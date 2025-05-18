extends Node2D
class_name EnemySpawner

const SNAKE := preload("res://scenes/npcs/snake_emeny.tscn")
const SCORPION := preload("res://scenes/npcs/scorpion_emeny.tscn")
const SNOWMAN := preload("res://scenes/npcs/snowman_emeny.tscn")
const MUSHROOM := preload("res://scenes/npcs/mushroom_npc.tscn")

const ENEMY_OPTIONS: Array = [SNAKE, SCORPION, SNOWMAN, MUSHROOM]

#@export var speed: int = 30
#@export var direction := 1
#@export var npc_bullet_speed: int = 75
#@export var state: Enemy_state
#@export var apply_gravity: bool = true
#@export var can_attack: bool = false
#@export var can_shoot: bool = false
#@export var attack_cooldown_time: float = 0.5

func spawn_enemies() -> void:
	var enemy_spawn_points = get_children()
	for enemy_point in enemy_spawn_points:
		var new_enemy = ENEMY_OPTIONS[enemy_point.enemy_option].instantiate()
		get_parent().get_node("Enemies").add_child(new_enemy)
		new_enemy.state = enemy_point.state
		new_enemy.global_position = enemy_point.global_position
		new_enemy.direction = enemy_point.direction
		new_enemy.speed = enemy_point.speed
		new_enemy.npc_bullet_speed = enemy_point.npc_bullet_speed
		new_enemy.apply_gravity = enemy_point.apply_gravity
		new_enemy.can_attack = enemy_point.can_attack
		new_enemy.can_shoot = enemy_point.can_shoot
		new_enemy.attack_cooldown_time = enemy_point.attack_cooldown_time
