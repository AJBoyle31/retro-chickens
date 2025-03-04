extends Control
class_name Menu

signal start_game

@onready var title_label: Label = %TitleLabel
@onready var start_button: Button = %StartButton


func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

func show_title_screen() -> void:
	title_label.show()
	start_button.show()

func hide_menu() -> void:
	title_label.hide()
	start_button.hide()


func _on_start_button_pressed() -> void:
	emit_signal("start_game")
