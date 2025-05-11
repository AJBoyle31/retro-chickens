extends Marker2D
class_name EnemyMarker

enum Enemy_state {IDLE, WALK, ATTACK, HIT}
enum Enemy_type {SNAKE, SCORPION, SNOWMAN, MUSHROOM}

@export_enum("snake", "scorpion", "snowman", "mushroom") var enemy_type: int
@export var enemy_option: Enemy_type
@export var speed: int = 30
@export var direction := 1
@export var npc_bullet_speed: int = 75
@export var state: Enemy_state  = Enemy_state.IDLE
@export var apply_gravity: bool = true
@export var can_attack: bool = false
@export var can_shoot: bool = false
@export var attack_cooldown_time: float = 0.5
