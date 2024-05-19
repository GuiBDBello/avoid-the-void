extends Control


@onready var game_over_menu: Control = $"CanvasLayer/Game Over Menu"
@onready var end_game_menu: Control = $"CanvasLayer/End Game Menu"
@onready var label: Label = $"CanvasLayer/End Game Menu/Panel/VBoxContainer/Label"
@onready var time_label: Label = $"CanvasLayer/End Game Menu/Panel/VBoxContainer/Time Label"


func _ready() -> void:
	game_over_menu.visible = false
	end_game_menu.visible = false


func _on_restart_button_pressed() -> void:
	Transition.transition()
	await Transition.on_transition_finished
	get_tree().reload_current_scene()


func _on_quit_button_pressed() -> void:
	Transition.transition()
	await Transition.on_transition_finished
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func show_game_over_menu() -> void:
	game_over_menu.visible = true


func show_end_game_menu(level_time: float) -> void:
	time_label.text = str("Time: ", round_to_dec(level_time, 3))
	end_game_menu.visible = true


func round_to_dec(num: float, digit: int) -> float:
	return round(num * pow(10.0, digit)) / pow(10.0, digit)
