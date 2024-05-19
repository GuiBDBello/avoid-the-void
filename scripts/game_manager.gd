extends Node


@export var game_menu: Control
@export var animation_player: AnimationPlayer

@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var texture_progress_bar: TextureProgressBar = $CanvasLayer/TextureProgressBar

var is_playable: bool
var level_timer: float = 0.0
var hold_to_skip_cutscene: float = 0.0


func _ready() -> void:
	GameManager.canvas_layer.visible = false
	canvas_layer.visible = false
	GameManager.animation_player = animation_player


func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_accept"):
		hold_to_skip_cutscene += delta * 100
	else:
		hold_to_skip_cutscene -= delta * 200
	
	if hold_to_skip_cutscene > 100.0:
		hold_to_skip_cutscene = 100.0
		GameManager.animation_player.speed_scale = 1000
	elif hold_to_skip_cutscene < 0.0:
		hold_to_skip_cutscene = 0.0
	
	texture_progress_bar.value = hold_to_skip_cutscene
	
	if GameManager.is_playable:
		level_timer += delta


func _on_the_void_player_absorbed() -> void:
	print("Player Absorbed!")
	GameManager.is_playable = false
	# animação do player sendo sugado para o void
	game_menu.show_game_over_menu()


func _on_rocketship_player_reached_rocketship() -> void:
	print("Reached Rocketship!")
	GameManager.is_playable = false
	game_menu.show_end_game_menu(level_timer)
	GameManager.animation_player.speed_scale = 1.0
	GameManager.animation_player.play("cutscene_game_win")


func _on_animation_player_animation_started(anim_name: StringName) -> void:
	match anim_name:
		"cutscene_game_start":
			print("cutscene start")
			GameManager.is_playable = false
			GameManager.canvas_layer.visible = true


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		"cutscene_game_start":
			print("cutscene end")
			GameManager.canvas_layer.visible = false
			GameManager.is_playable = true
