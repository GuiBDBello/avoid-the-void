extends MeshInstance3D


@onready var collision_shape: CollisionShape3D = $StaticBody3D/CollisionShape3D

@onready var player: CharacterBody3D = $"../../Player"

@export var speed: float = 2.0

var cut_player_height: float = 0.2


func _physics_process(delta: float) -> void:
	position.y -= speed * delta
	
	if player.global_transform.origin.y > self.global_transform.origin.y + cut_player_height: #Add more if the origin of the player is centred.
		collision_shape.disabled = false
	else:
		collision_shape.disabled = true
