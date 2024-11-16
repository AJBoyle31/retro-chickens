extends Node2D
class_name Level

@export var time_to_complete: float = 30.0
@export var bullet_count: int = 5

var total_chickens: int
var chickens_left: int
var has_chicken_died: bool = false

@onready var camera_2d: Camera2D = $Camera2D
@onready var player: Player = $Player
@onready var hud = $UI/HUD
@onready var time_left_to_complete: Timer = $TimeLeftToComplete


func _ready() -> void:
	#Player Updates
	player.set_bullet_count(bullet_count)
	player.connect("shoot", _on_player_shoot)
	hud.update_bullet_count(bullet_count)
	#Chicken Updates
	var chickens = get_tree().get_nodes_in_group("chickens")
	total_chickens = chickens.size()
	chickens_left = chickens.size()
	hud.update_chickens_remaining(total_chickens, has_chicken_died)
	connect_chicken_signals(chickens)
	#Time Updates
	hud.update_time_label(time_to_complete)
	time_left_to_complete.start(time_to_complete)

func _process(_delta: float) -> void:
	camera_2d.global_position = player.global_position
	hud.update_time_label(time_left_to_complete.time_left)

#Player shot the gun, handles bullets
func _on_player_shoot(Bullet):
	if bullet_count > 0: 
		bullet_count -= 1
		update_bullet_counts()
		var bullet_instance = Bullet.instantiate()
		add_child(bullet_instance)
		bullet_instance.global_position = player.global_position
		if !player.player_sprite.flip_h:
			bullet_instance.direction = 1
			bullet_instance.global_position.x += 10
		else:
			bullet_instance.direction = -1
			bullet_instance.global_position.x -= 2

#Chicken Signals
func connect_chicken_signals(_chickens) -> void:
	for chicken in _chickens:
		chicken.connect("chicken_collected", _update_chicken_count)


#HUD Updates
func update_bullet_counts() -> void:
		hud.update_bullet_count(bullet_count)
		player.set_bullet_count(bullet_count)

func _update_chicken_count(_was_chicken_collected) -> void:
	chickens_left -= 1
	if !_was_chicken_collected:
		has_chicken_died = true
	hud.update_chickens_remaining(chickens_left, has_chicken_died)
