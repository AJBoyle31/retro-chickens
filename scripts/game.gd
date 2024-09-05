extends Node2D
class_name Game


@onready var hud: Control = $UI/HUD



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Use this for UI
	var chickens = get_tree().get_nodes_in_group("chickens")
	print("Chickens: " + str(chickens.size()))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
