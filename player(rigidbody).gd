extends RigidBody3D

var speed = 80
var jump_vel = 12
var health = 100

var max_speed = 14
var fric = 20

var base_fov = 75
var fov = 75
var fov_recovery = 2
var runfov = 0

@export var head: Node3D
@export var cam: Camera3D

@export var floorcast: RayCast3D
@export var fade_in_out: ColorRect

var can_jump = true
var was_on_floor = true

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	#$fade_in_out.fade(1, -1)
	

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
	
	%cam.fov = fov

func _physics_process(delta: float) -> void:
	speed_lines(delta)
	use_floorcast(delta)
	
	if linear_velocity.y < -60:
		linear_velocity.y = -60


	$floorcast.enabled = true
	
	
	if $floorcast.is_colliding():
		was_on_floor = true
	else:
		if was_on_floor:
			was_on_floor = false
			$cyote_time.start()
	#cyote_time()
	#jump_bufer()
	
	if Input.is_action_just_pressed("jump") or $jump_buffer.is_stopped() == false and Global.in_menu == false:
		#if linear_velocity.y < 0:
			#linear_velocity.y = 0
		
		if floorcast.is_colliding() or $cyote_time.is_stopped() == false:
			#if linear_velocity.y < 0:
				#linear_velocity.y = 0
			$sounds.step_sound()
			if linear_velocity.y < 6:
				linear_velocity.y = 0
				$floorcast.enabled = false
		#apply_central_impulse(Vector3.UP * jump_vel)
			linear_velocity.y += jump_vel
			$cyote_time.stop()
			$jump_buffer.stop()
		else:
			if $jump_buffer.is_stopped():
				$jump_buffer.start()
		#print("Jump")
	#Global.in_menu = false
	
	var speed_bump = 0
	var damp = 3.0
	if $floorcast.is_colliding():
		damp = 6.0
		speed_bump = 20
	var factor = max(0.0, 1.0 - damp * delta)
	var v := linear_velocity
	v.x *= factor
	v.z *= factor
	linear_velocity = v
	
	
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction and Global.in_menu == false:
		if (linear_velocity * direction).length() < max_speed:
			apply_central_force((speed + speed_bump) * direction)
	
	#if %int_cast.is_colliding():
	if %int_cast.get_collider() != null and %int_cast.get_collider().has_method("interacted") and Global.in_menu == false:
		$Control/int_indicator.show()
		if Input.is_action_just_pressed("interact"):
			#print("insfdg")
			%int_cast.get_collider().interacted()
	else:
		$Control/int_indicator.hide()
	
	#linear_velocity.x = move_toward(linear_velocity.x, 0, fric * delta)
	#linear_velocity.z = move_toward(linear_velocity.z , 0, fric * delta)
		#velocity.x = move_toward(velocity.x, direction.x * speed, acc * delta)
		#velocity.z = move_toward(velocity.z, direction.z * speed, acc * delta)
	#else:
		#velocity.x = move_toward(velocity.x, 0, fric * delta)
		#velocity.z = move_toward(velocity.z, 0, fric * delta)

func speed_lines(delta):
	var line_intensity
	#if linear_velocity.length() > 10:
		#line_intensity = (linear_velocity.length() - 10) / 10
	line_intensity = linear_velocity.length() / 100
	line_intensity = clamp(0.8 - line_intensity, 0.5 , 1.0)
	$"Control/speed lines".material.set_shader_parameter("mask_edge", line_intensity)

func use_floorcast(delta):
	if floorcast.is_colliding():
		var springstrength = 200 #180
		var damping = 16 #12
		
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
		
		var x = (floorcast.global_position.distance_to(floorcast.get_collision_point()) - 1.4) * -1
		var spring_force = (x * springstrength) + -linear_velocity.y * damping
		#spring_force = clamp(spring_force, -300.0, 300.0)
		#print(-linear_velocity.y * damping)
		apply_central_force(Vector3.UP * spring_force)

func dialogue():
	pass

func hit(dmg):
	health -= dmg
	$Control/healthbar.value = health
	#%cam_holder.shake(2.4 + dmg * 0.04, 180.0)
	#%cam_holder.shake(2.0 + dmg * 0.02, 20, 0.5)
	%cam_holder.shake(2.0 + dmg * 0.028, 10, 10)
	$Control/hit_effect.show_effect(clamp(0.4 + dmg * 0.01, 0, 1), 2.0)
	$"sounds/hit 1".play()
	
	if health <= 0:
		die()

func die():
	#Global.in_menu = true
	Global.change_scene("res://hub world.tscn")
	#get_tree().change_scene_to_file("res://hub world.tscn")
	
