extends Node3D


signal player_reached_rocketship


func _on_area_3d_body_entered(body: Node3D) -> void:
	print("Game Finished!")
	player_reached_rocketship.emit()
	# desativar player input
	# tocar música de vitória
	# parar o void no local que está
	# animação do player entrando na nave e saindo do planeta
	# mostrar menu de end game com pontuação (tempo final)
