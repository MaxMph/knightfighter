extends RigidBody3D

var speed = 80
var jump_vel = 18
var health = 100

var max_speed = 18
var fric = 20

var base_fov = 75
var fov = 75
var fov_recovery = 2
var runfov = 0

@export var head: Node3D
@export var cam: Camera3D

@export var floorcast: RayCast3D

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * Global.sense)
		cam.rotate_x(-event.relative.y * Global.sense)
		cam.rotation.x = clamp(cam.rotation.x, deg_to_rad(-75), deg_to_rad(75))
		


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
	
	use_floorcast(delta)
	
	%cam.fov = fov

func _physics_process(delta: float) -> void:
	

	if Input.is_action_just_pressed("jump"):
		if linear_velocity.y < 0:
			linear_velocity.y = 0
		#apply_central_impulse(Vector3.UP * jump_vel)
		linear_velocity.y += jump_vel
		print("Jump")
	
	
	var damp := 4.0  # same value you'd use for linear_damp
	var factor = max(0.0, 1.0 - damp * delta)
	var v := linear_velocity
	v.x *= factor
	v.z *= factor
	linear_velocity = v
	
	
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		if (linear_velocity * direction).length() < max_speed:
			apply_central_force(speed * direction)
	
	
	#linear_velocity.x = move_toward(linear_velocity.x, 0, fric * delta)
	#linear_velocity.z = move_toward(linear_velocity.z , 0, fric * delta)
		#velocity.x = move_toward(velocity.x, direction.x * speed, acc * delta)
		#velocity.z = move_toward(velocity.z, direction.z * speed, acc * delta)
	#else:
		#velocity.x = move_toward(velocity.x, 0, fric * delta)
		#velocity.z = move_toward(velocity.z, 0, fric * delta)


func use_floorcast(delta):
	if floorcast.is_colliding():
		var springstrength = 180
		var damping = 12
		
		#var floor_dist = (abs(floorcast.target_position.y) * 2 - floorcast.global_position.distance_to(floorcast.get_collision_point())) / 2
		#var vertical_velocity = linear_velocity.dot(Vector3.UP)
		#var damping_force = -vertical_velocity * dampinglinear_velocity.y < 0
		#var damp = 1
		#if linear_velocity.y > 0:
			#damp = 1 + linear_velocity.y
		#linear_velocity.y = move_toward(linear_velocity.y, 0, delta * damping)
		#apply_central_force((springforce / damp) * (floor_dist) * Vector3.UP)
		
		# Distance error
		#var x := floorcast.get_collision_point().distance_to(floorcast.global_position) - ride_height
		#var floor_dist = floorcast.global_position.distance_to(floorcast.get_collision_point()) - 1.0#0.8
		
		#var damp = min(linear_velocity.y * damping, -floor_dist * springstrength)
		#var spring_force = (-floor_dist * springstrength) - damp
		#var spring_force = (floor_dist * springstrength) - (linear_velocity.y * damping)
		# Clamp to avoid spikes
		#spring_force = clamp(spring_force, -300.0, 300.0)
		# Apply force
		#apply_central_force(Vector3.UP * -spring_force)
		
		#var x = 1 - floorcast.global_position.distance_to(floorcast.get_collision_point())
			#
		
		var x = (floorcast.global_position.distance_to(floorcast.get_collision_point()) - 0.8) * -1
		var spring_force = (x * springstrength) + -linear_velocity.y * damping
		#spring_force = clamp(spring_force, -300.0, 300.0)
		#print(-linear_velocity.y * damping)
		apply_central_force(Vector3.UP * spring_force)
