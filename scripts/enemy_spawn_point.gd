extends Marker2D
class_name EnemyMarker

@export_enum("snake", "scorpion") var enemy_type: int
@export_enum("idle", "walk") var enemy_state: String = "idle"
@export var speed: int = 30
@export var direction := 1
