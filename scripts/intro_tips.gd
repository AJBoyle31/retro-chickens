extends Control


var player_jumped: bool = false

@onready var movement_label: Label = $MovementLabel
@onready var jump_label: Label = $JumpLabel



func _ready() -> void:
	pass # Replace with function body.


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		player_jumped = true


func _on_movement_tip_body_exited(_body: Node2D) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(movement_label,"scale", Vector2(), 1)
	tween.tween_callback(movement_label.hide)


func _on_jump_tip_body_entered(_body: Node2D) -> void:
	if player_jumped:
		jump_label.hide()


func _on_jump_tip_body_exited(_body: Node2D) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(jump_label,"scale", Vector2(), 1)
	tween.tween_callback(jump_label.hide)
