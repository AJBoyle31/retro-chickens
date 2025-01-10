extends CharacterBody2D
class_name Chicken

signal chicken_collected(was_chicken_collected: bool)


@export_enum("idle", "walk") var state: String = "idle"
@export var speed: int = 30
@export var direction := 1


var gravity := 100
var is_hit: bool = false
var signal_emitted: bool = false
var showing_collection_label: bool = false


@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite
@onready var ray_cast_right: RayCast2D = %RayCastRight
@onready var ray_cast_left: RayCast2D = %RayCastLeft
@onready var chicken_hurtbox: HurtBox = %HurtBox
@onready var collect_label: Label = %CollectLabel


func _ready() -> void:
	collect_label.hide()

func _process(delta: float) -> void:
	
	if is_hit:
		animated_sprite.play("hit")
		velocity.x = 0
		
	else:
		if not is_on_floor():
			velocity.y += gravity * delta
			animated_sprite.play("walk")
		
		if state == "walk" and is_on_floor():
			velocity.x = direction * speed
			animated_sprite.play("walk")
		
		if state == "idle" and is_on_floor():
			velocity.x = 0
			animated_sprite.play("idle")
		
		if ray_cast_left.is_colliding():
			direction = 1
		
		if ray_cast_right.is_colliding():
			direction = -1
	
	handle_facing_direction(direction)
	move_and_slide()


func kill_npc() -> void:
	queue_free()

func handle_facing_direction(_direction) -> void: 
	if _direction > 0:
		animated_sprite.flip_h = false
		chicken_hurtbox.position.x = 0
	elif _direction < 0:
		animated_sprite.flip_h = true
		chicken_hurtbox.position.x = 2

func chicken_has_died() -> void:
	if !signal_emitted:
			emit_signal("chicken_collected", false)
			signal_emitted = true
			kill_npc()

func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area.has_method("destroy_bullet"):
		area.destroy_bullet()
		is_hit = true

func _on_hurt_box_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		collect_label.show()
		showing_collection_label = true


func _on_hurt_box_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		collect_label.hide()
		showing_collection_label = false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("collect_chicken") and showing_collection_label:
		if !signal_emitted:
			emit_signal("chicken_collected", true)
			signal_emitted = true
		kill_npc()
