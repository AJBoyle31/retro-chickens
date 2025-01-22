extends Marker2D
class_name EnemyMarker

#@export_enum("snake", "enemy2", "enemy3")
@export_enum("idle", "walk") var state: String = "idle"
@export var speed: int = 30
@export var direction := 1
