extends Control

@onready var bullet_label: Label = %BulletLabel
@onready var time_label: Label = %TimeLabel
@onready var chickens_label: Label = %ChickensLabel
@onready var label_animation_player: AnimationPlayer = %LabelAnimationPlayer
@onready var state_label: Label = %StateLabel
@onready var velocity_label: Label = %VelocityLabel


func update_bullet_count(bullets_remaining: int) -> void:
	bullet_label.text = "Bullets Left: " + str(bullets_remaining)

func update_time_label(time_remaining: float) -> void:
	var time_remaining_int = int(time_remaining)
	time_label.text = "Time Remaining: " + str(time_remaining_int)

func update_chickens_remaining(chickens_remaining: int, label_red:bool) -> void:
	chickens_label.text = "Chickens Left: " + str(chickens_remaining)
	if label_red:
		chickens_label.add_theme_color_override("font_color", Color.RED)
		label_animation_player.play("chickens_dying_label_blink")

func player_is_dead() -> void:
	print("hud death")

func update_state_label(new_state) -> void:
	match new_state:
		0: 
			state_label.text = "Idle"
		1: 
			state_label.text = "Walk"
		2: 
			state_label.text = "Jump"
		3: 
			state_label.text = "Hit"
		4: 
			state_label.text = "Shoot"
		5: 
			state_label.text = "Dead"

func update_velocity_label(new_velocity) -> void:
	velocity_label.text = "Velocity: " + str(new_velocity)
