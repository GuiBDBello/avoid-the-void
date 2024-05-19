extends Node


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var pause_menu: CanvasLayer = $"Pause Menu"

var paused = false


func _ready() -> void:
	print("Game start!")
	animation_player.play("cutscene_game_start")


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pause()


func pause():
	if GameManager.is_playable:
		paused = !paused
		pause_menu.visible = paused
		
		if paused:
			Engine.time_scale = 0
		else:
			Engine.time_scale = 1


func _on_resume_button_pressed() -> void:
	pause()


func _on_restart_button_pressed() -> void:
	pause_menu.visible = false
	Engine.time_scale = 1
	Transition.transition()
	await Transition.on_transition_finished
	get_tree().reload_current_scene()


func _on_quit_button_pressed() -> void:
	pause_menu.visible = false
	Engine.time_scale = 1
	Transition.transition()
	await Transition.on_transition_finished
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
