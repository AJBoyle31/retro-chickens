extends Node2D
class_name NPC

#@export_enum("idle", "walk") var state: String = "idle"
var state: String
@export var speed: int = 30
var npc_bullet_speed: int = 0

var direction := 1
var npc_state: String
var is_frozen: bool = false

@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite
@onready var ray_cast_right: RayCast2D = %RayCastRight
@onready var ray_cast_left: RayCast2D = %RayCastLeft
@onready var npc_hitbox: Area2D = %NPCHitbox

#NEED TO FIX ANIMATION PLAYING FOR EXPORTED STATE
func _ready() -> void:
	pass
	#print(state)


func _process(_delta: float) -> void:
	pass

func idle(_delta: float) -> void:
	handle_facing_direction()
	animated_sprite.play("idle")

func walking(_delta) -> void:
	animated_sprite.play("walk")
	if ray_cast_left.is_colliding():
		direction = 1
	if ray_cast_right.is_colliding():
		direction = -1
	
	handle_facing_direction()
	
	position.x += speed * direction * _delta



func handle_facing_direction() -> void: 
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true



func kill_npc() -> void:
	queue_free()


func _on_npc_hitbox_area_entered(area: Area2D) -> void:
	if area.name.contains("PlayerBullet"):
		print("PLAYER BULLET HIT!")
		state = "hit"
		is_frozen = true
		if area.has_method("destroy_bullet"):
			area.destroy_bullet()
