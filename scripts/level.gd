extends Node2D
class_name Level

@export var bullets_remaining: int = 3


@onready var camera_2d: Camera2D = $Camera2D
@onready var player: Player = $Player


func _ready() -> void:
	pass



func _process(_delta: float) -> void:
	camera_2d.global_position = player.global_position
