extends Node3D


const FALLING_PLATFORM_BIG = preload("res://scenes/falling_platform_big.tscn")
const FALLING_PLATFORM_MID = preload("res://scenes/falling_platform_mid.tscn")
const FALLING_PLATFORM_SM = preload("res://scenes/falling_platform_sm.tscn")
const FALLING_PLATFORM_XSM = preload("res://scenes/falling_platform_xsm.tscn")

@export var parent_node: Node


func _on_spawn_platform_timeout() -> void:
	spawn_platform(get_platform(), get_random_position())


func get_random_position() -> Vector3:
	return Vector3(randi_range(-8, 8), self.position.y, 0)


func get_platform() -> MeshInstance3D:
	var platform
	match self.position.y:
		79.5:
			platform = FALLING_PLATFORM_BIG.instantiate()
		119.5:
			platform = FALLING_PLATFORM_MID.instantiate()
		159.5:
			platform = FALLING_PLATFORM_SM.instantiate()
		200.0:
			platform = FALLING_PLATFORM_XSM.instantiate()
		_:
			print("Wrong spawn position!")
		
	return platform


func spawn_platform(platform: MeshInstance3D, spawn_position: Vector3) -> void:
	platform.position = spawn_position
	parent_node.add_child(platform)
