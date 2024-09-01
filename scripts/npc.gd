extends Node
class_name NPC

@export_enum("idle", "walk") var state: String = "idle"
@export var speed: int = 30

var direction := 1


@onready var animated_sprite = $AnimatedSprite
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_right: RayCast2D = $RayCastRight

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
