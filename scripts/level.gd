extends Node2D
class_name Level

signal update_bullets_remaining(bullets_remaining)

@export var bullet_count: int = 5

@onready var camera_2d: Camera2D = $Camera2D
@onready var player: Player = $Player


func _ready() -> void:
	player.set_bullet_count(bullet_count)
	player.connect("shoot", _on_player_shoot)
	var parent = get_parent()
	#This isn't working :(
	parent.connect("update_bullets_remaining", parent._on_bullet_update)


func _process(_delta: float) -> void:
	camera_2d.global_position = player.global_position

func _on_player_shoot(Bullet):
	if bullet_count > 0: 
		bullet_count -= 1
		update_bullets_remaining.emit(bullet_count)
		player.set_bullet_count(bullet_count)
		var bullet_instance = Bullet.instantiate()
		add_child(bullet_instance)
		bullet_instance.global_position = player.global_position
		if !player.player_sprite.flip_h:
			bullet_instance.direction = 1
			bullet_instance.global_position.x += 10
		else:
			bullet_instance.direction = -1
			bullet_instance.global_position.x -= 2
