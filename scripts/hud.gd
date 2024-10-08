extends Control

@onready var bullet_label: Label = $HBoxContainer/BulletLabel
@onready var time_label: Label = $HBoxContainer/TimeLabel
@onready var chickens_label: Label = $HBoxContainer/ChickensLabel




func update_bullet_count(bullets_remaining: int) -> void:
	bullet_label.text = "Bullets Left: " + str(bullets_remaining)

func update_time_label(time_remaining: float) -> void:
	var time_remaining_int = int(time_remaining)
	time_label.text = "Time Remaining: " + str(time_remaining_int)

func update_chickens_remaining(chickens_remaining: int) -> void:
	chickens_label.text = "Chickens Left: " + str(chickens_remaining)
