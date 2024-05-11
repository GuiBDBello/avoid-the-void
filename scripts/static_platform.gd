extends MeshInstance3D


@onready var player: CharacterBody3D = $"../../Player"

var cut_player_height: float = 0.2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print("player", player.global_transform.origin.y)
	print("platform", self.global_transform.origin.y)
	if player.global_transform.origin.y > self.global_transform.origin.y + cut_player_height: #Add more if the origin of the player is centred.
		print("if")
		self.get_node("./StaticBody3D/CollisionShape3D").disabled = false
	else:
		print("else")
		self.get_node("./StaticBody3D/CollisionShape3D").disabled = true
