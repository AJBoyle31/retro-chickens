extends Marker2D
class_name ChickenMarker

@export_enum("idle", "walk") var state: String = "idle"
@export var speed: int = 30
@export var direction := 1
