extends Node2D
class_name ChickenSpawner


const CHICKEN := preload("res://scenes/npcs/chicken.tscn")


func spawn_chickens() -> void:
	var chicken_spawn_points = get_children()
	for chicken_point in chicken_spawn_points:
		var new_chicken = CHICKEN.instantiate()
		new_chicken.global_position = chicken_point.global_position
		get_parent().get_node("Chickens").add_child(new_chicken)
		new_chicken.state = chicken_point.state
		new_chicken.direction = chicken_point.direction
		new_chicken.speed = chicken_point.speed
		
		
