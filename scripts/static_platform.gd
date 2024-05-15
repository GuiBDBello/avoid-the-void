extends Node3D


@onready var collision_shape: CollisionShape3D = $Graphics/StaticBody3D/CollisionShape3D

@onready var player: CharacterBody3D = $"../../Player"

var cut_player_height: float = 0.2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if player.global_transform.origin.y > self.global_transform.origin.y + cut_player_height: #Add more if the origin of the player is centred.
		collision_shape.disabled = false
	else:
		collision_shape.disabled = true
