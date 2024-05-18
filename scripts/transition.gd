extends CanvasLayer


signal on_transition_finished


@onready var color_rect: ColorRect = $ColorRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	color_rect.visible = false
	animation_player.animation_finished.connect(_on_animation_player_animation_finished)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		"fade_out":
			on_transition_finished.emit()
			animation_player.play("fade_in")
		"fade_in":
			color_rect.visible = false


func transition() -> void:
	color_rect.visible = true
	animation_player.play("fade_out")
