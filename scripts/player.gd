extends CharacterBody3D


#const SPEED = 5.0
#const JUMP_VELOCITY = 4.5

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


func _ready() -> void:
	calculate_movement_parameters()


func _input(event) -> void:
	if event.is_action_released("jump"):
		if velocity.y > 0.0:
			velocity.y *= 0.5


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		if velocity.y > 0:
			velocity.y -= jump_gravity * delta
		else:
			velocity.y -= fall_gravity * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, 0)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()
	

func calculate_movement_parameters() -> void:
	jump_gravity = (2 * jump_height) / pow(jump_peak_time, 2)
	fall_gravity = (2 * jump_height) / pow(jump_fall_time, 2)
	jump_velocity = jump_gravity * jump_peak_time
	#speed = jump_distance / (jump_peak_time * jump_fall_time)
	jump_distance = speed * (jump_peak_time * jump_fall_time)
