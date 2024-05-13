extends CharacterBody3D


@export_category("Movement Parameters")
@export var jump_peak_time: float = .5
@export var jump_fall_time: float = .4
@export var jump_height: float = 2.0
var jump_distance: float = 4.0

@export var speed: float = 20.0
var jump_velocity: float = 5.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var jump_gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var fall_gravity: float = 5.0

@onready var collision_shape: CollisionShape3D = $CollisionShape3D
@onready var ray_cast: RayCast3D = $RayCast3D

@onready var main_camera: Camera3D = $"Main Camera"
@onready var player_camera: Camera3D = $"Main Camera/SubViewportContainer/SubViewport/Player Camera"
@onready var sub_viewport: SubViewport = $"Main Camera/SubViewportContainer/SubViewport"


func _ready() -> void:
	calculate_movement_parameters()


func _input(event) -> void:
	if Game.is_playable:
		if event.is_action_released("jump") or event.is_action_released("move_up"):
				if velocity.y > 0.0:
					velocity.y *= 0.5


func _process(delta) -> void:
	player_camera.global_transform = main_camera.global_transform
	
	var root_viewport = main_camera.get_viewport()
	var player_viewport = player_camera.get_viewport()


func _physics_process(delta: float) -> void:
	if Game.is_playable:
		
		#if Input.is_action_just_pressed("jump") or Input.is_action_just_pressed("move_up"):
			#if velocity.y > 0.0:
				#velocity.y *= 0.5
		
		# Add the gravity.
		if not is_on_floor():
			if velocity.y > 0:
				velocity.y -= jump_gravity * delta
			else:
				velocity.y -= fall_gravity * delta
		
		if Input.is_action_just_pressed("move_down"):
			var collider = ray_cast.get_collider()
			if collider is StaticBody3D:
				print("is staticbody")
				collision_shape.disabled = true
				while(ray_cast.get_collider() != null):
					await get_tree().create_timer(.25).timeout
				collision_shape.disabled = false
		
		# Handle jump.
		if (Input.is_action_just_pressed("jump") or Input.is_action_just_pressed("move_up")) and is_on_floor():
			velocity.y = jump_velocity

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
		var direction := (transform.basis * Vector3(input_dir.x, 0, 0)).normalized()
		if direction:
			velocity.x = direction.x * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)

		move_and_slide()


func calculate_movement_parameters() -> void:
	jump_gravity = (2 * jump_height) / pow(jump_peak_time, 2)
	fall_gravity = (2 * jump_height) / pow(jump_fall_time, 2)
	jump_velocity = jump_gravity * jump_peak_time
	#speed = jump_distance / (jump_peak_time * jump_fall_time)
	jump_distance = speed * (jump_peak_time * jump_fall_time)
	print("Jump Distance: ", jump_distance)
