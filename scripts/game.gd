extends Node


@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	print("Game start!")
	animation_player.play("cutscene_game_start")
