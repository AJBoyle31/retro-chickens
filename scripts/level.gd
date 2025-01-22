extends Node2D
class_name Level

@export var time_to_complete: float = 30.0
@export var bullet_count: int = 5

const PLAYER_SCENE := preload("res://scenes/player/player.tscn")
const CHICKEN := preload("res://scenes/npcs/chicken.tscn")

var total_chickens: int
var chickens_left: int
var bullets_left: int
var player: Player

@onready var camera_2d: Camera2D = %Camera2D
@onready var hud: Control = %HUD
@onready var time_left_to_complete: Timer = %TimeLeftToComplete
@onready var level_reset_timer: Timer = %LevelResetTimer
@onready var next_level_box: NextLevel = %NextLevel
@onready var right_killzone: KillZone = %RightKillzone
@onready var left_killzone: KillZone = %LeftKillzone
@onready var player_marker_2d: Marker2D = %PlayerMarker2D
@onready var chicken_spawner: ChickenSpawner = %ChickenSpawner



func _ready() -> void:
	spawn_player()
	spawn_chickens()
	
	hud.update_bullet_count(bullet_count)
	bullets_left = bullet_count
	
	#Time Updates
	hud.update_time_label(time_to_complete)
	time_left_to_complete.start(time_to_complete)
	next_level_box.connect("can_level_change", _can_the_level_change)
	
	#Keep camera from going past level ends
	camera_2d.limit_left = left_killzone.position.x + 16
	camera_2d.limit_right = right_killzone.position.x - 16
	

func _process(_delta: float) -> void:
	if player != null:
		camera_2d.global_position = player.global_position
		#Debugging Player 
		hud.update_velocity_label(player.velocity)
		hud.update_state_label(player.player_state)
	hud.update_time_label(time_left_to_complete.time_left)
	

func spawn_player() -> void:
	player = PLAYER_SCENE.instantiate()
	player.global_position = player_marker_2d.global_position
	get_node("PlayerSpawn").add_child(player)
	player.set_bullet_count(bullet_count)
	player.connect("shoot", _on_player_shoot)
	player.connect("player_has_died", _on_player_death)
	player.enable_player()
	

func spawn_chickens() -> void:
	var chicken_spawn_points = chicken_spawner.get_children()
	for chicken_point in chicken_spawn_points:
		var new_chicken = CHICKEN.instantiate()
		new_chicken.global_position = chicken_point.global_position
		new_chicken.connect("chicken_collected", update_chicken_count)
		get_node("Chickens").add_child(new_chicken)
		new_chicken.add_to_group("chickens")
		new_chicken.state = chicken_point.state
		new_chicken.direction = chicken_point.direction
		new_chicken.speed = chicken_point.speed
	total_chickens = get_tree().get_nodes_in_group("chickens").size()
	chickens_left = total_chickens
	hud.update_chickens_remaining(total_chickens, false)

func spawn_enemies() -> void:
	pass

func reset_hud() -> void:
	bullets_left = bullet_count
	update_bullet_counts(bullet_count)
	hud.update_time_label(time_to_complete)
	time_left_to_complete.start(time_to_complete)
	hud.update_chickens_remaining(total_chickens, false)

#Player shot the gun, handles bullets
func _on_player_shoot(Bullet):
	if bullets_left > 0: 
		bullets_left -= 1
		update_bullet_counts(bullets_left)
		var bullet_instance = Bullet.instantiate()
		add_child(bullet_instance)
		bullet_instance.global_position = player.global_position
		if !player.player_sprite.flip_h:
			bullet_instance.direction = 1
			bullet_instance.global_position.x += 10
		else:
			bullet_instance.direction = -1
			bullet_instance.global_position.x -= 2



#HUD Updates
func update_bullet_counts(_bullets_to_update) -> void:
		hud.update_bullet_count(_bullets_to_update)
		player.set_bullet_count(_bullets_to_update)

func update_chicken_count(_was_chicken_collected) -> void:
	var has_chicken_died: bool = false
	chickens_left -= 1
	if !_was_chicken_collected:
		has_chicken_died = true
	hud.update_chickens_remaining(chickens_left, has_chicken_died)

func _on_player_death() -> void:
	print("level death")
	hud.player_is_dead()
	level_reset_timer.start(0.5)
	


#Going to update this so that the player is respawned at new spawn point
func _on_level_reset_timer_timeout() -> void:
	#SignalManager.restart_current_level.emit()
	#get_tree().reload_current_scene()
	#spawn_player()
	restart_level()

func _can_the_level_change() -> void:
	if chickens_left == 0:
		SignalManager.change_level.emit(next_level_box.next_level.instantiate())
		player.disable_player()

#What happens when the player doesn't finish collecting the chickens in time
func _on_time_left_to_complete_timeout() -> void:
	if chickens_left > 0:
		pass
		#restart_level()
		#need some sore of HUD message to let the player know they're shit

func restart_level() -> void:
	var to_be_deleted = get_tree().get_nodes_in_group("level_restart")
	for thing in to_be_deleted:
		thing.get_parent().remove_child(thing)
		thing.queue_free()
		
	spawn_player()
	spawn_chickens()
	spawn_enemies()
	reset_hud()
