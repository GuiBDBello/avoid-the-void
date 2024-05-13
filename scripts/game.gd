extends Node


@onready var game_menu: Node = $"Game Menu"

var is_playable: bool
var level_timer: float = 0.0


func _ready() -> void:
	Game.is_playable = true


func _process(delta: float) -> void:
	level_timer += delta


func end_game() -> void:
	Game.is_playable = false
	game_menu.show_end_game_menu()
	print("Time: ", level_timer)


func _on_the_void_player_absorbed() -> void:
	# parar o void no lugar
	Game.is_playable = false
	# animação do player sendo sugado para o void
	game_menu.show_game_over_menu()


func _on_rocketship_player_reached_rocketship() -> void:
	# parar o void
	Game.is_playable = false
	# animação do player fugindo
	game_menu.show_end_game_menu(level_timer)
