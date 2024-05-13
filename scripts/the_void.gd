extends Node3D


signal player_absorbed

@export var speed: float = 4.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if Game.is_playable:
		if position.y < 80:
			position.y += speed * delta
		elif position.y < 120:
			position.y += (speed / 2) * delta
		else:
			position.y += (speed / 4) * delta


func _on_area_3d_body_entered(body: Node3D) -> void:
	print("Game Over!")
	player_absorbed.emit()
	# desativar input do player
	# tocar música de derrota
	# puxar o player pro centro do void (animação)
	# await 1 ou 2 segundos
	# mostrar menu de fim de jogo
