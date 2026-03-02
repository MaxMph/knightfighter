extends RigidBody3D

var speed = 40
var jump_vel = 6
var health = 100

var max_speed = 14

var base_fov = 75
var fov = 75
var fov_recovery = 2
var runfov = 0

@export var head: Node3D
@export var cam: Camera3D

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * Global.sense)
		cam.rotate_x(-event.relative.y * Global.sense)
		cam.rotation.x = clamp(cam.rotation.x, deg_to_rad(-75), deg_to_rad(75))
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Control/fps.text = str(Engine.get_frames_per_second())
	$Control/speed.text = str(roundi(linear_velocity.length()))
	
	if fov != base_fov:
		fov = move_toward(fov, base_fov, delta * fov_recovery)
	
	if linear_velocity.length() > 6:
		#var run_fov_change = (base_fov + linear_velocity.length()) - 6
		#fov = move_toward(fov, base_fov + linear_velocity.length(), delta * 20)
		fov = base_fov + (linear_velocity.length() - 6) / 4
		#fov = base_fov + move_toward(0, linear_velocity.length(), delta * 20)
	
	%cam.fov = fov

func _physics_process(delta: float) -> void:
	

	if Input.is_action_just_pressed("jump"):
		apply_central_impulse(Vector3.UP * jump_vel)
	
	
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		if (linear_velocity + direction).length() < max_speed:
			apply_central_force(speed * direction)
		#velocity.x = move_toward(velocity.x, direction.x * speed, acc * delta)
		#velocity.z = move_toward(velocity.z, direction.z * speed, acc * delta)
	#else:
		#velocity.x = move_toward(velocity.x, 0, fric * delta)
		#velocity.z = move_toward(velocity.z, 0, fric * delta)
