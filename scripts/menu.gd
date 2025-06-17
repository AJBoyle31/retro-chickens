extends Control
class_name Menu

signal start_game

@onready var title_label: Label = %TitleLabel
@onready var start_button: Button = %StartButton
@onready var start_v_box_container: VBoxContainer = %StartVBoxContainer
@onready var pause_v_box_container: VBoxContainer = %PauseVBoxContainer
@onready var pause_panel_container: PanelContainer = $CenterContainer/PausePanelContainer
@onready var tilemaps: Node2D = $CenterContainer/StartVBoxContainer/Tilemaps



func _ready() -> void:
	pause_panel_container.hide()

func _process(_delta: float) -> void:
	pass

func show_title_screen() -> void:
	start_v_box_container.show()


func hide_menu() -> void:
	var tiles = tilemaps.get_children()
	for tile in tiles:
		tile.collision_enabled = false
	start_v_box_container.hide()

func paused_screen(show_menu:bool) -> void:
	if show_menu:
		pause_panel_container.show()
	else:
		pause_panel_container.hide()

func _on_start_button_pressed() -> void:
	emit_signal("start_game")
