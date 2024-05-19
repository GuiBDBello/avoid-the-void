extends Node3D


signal player_reached_rocketship


@export var static_flame: GPUParticles3D
@export var flames: GPUParticles3D
@export var smoke: GPUParticles3D
@export var particles_floating: GPUParticles3D


func _on_area_3d_body_entered(body: Node3D) -> void:
	print("Game Finished!")
	player_reached_rocketship.emit()
	ignite(true)
	# tocar música de vitória


func ignite(emitting: bool) -> void:
	static_flame.emitting = emitting
	flames.emitting = emitting
	smoke.emitting = emitting
	particles_floating.emitting = emitting
