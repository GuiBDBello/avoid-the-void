extends Node


@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	GameManager.canvas_layer.visible = false
	animation_player.play("main_menu")


func _on_play_button_pressed() -> void:
	Transition.transition()
	await Transition.on_transition_finished
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_quit_button_pressed() -> void:
	Transition.transition()
	await Transition.on_transition_finished
	get_tree().quit()
