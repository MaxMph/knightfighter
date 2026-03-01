extends CharacterBody3D

var jump_vel = 6
var speed = 8
var acc = 20
var fric = 20

@export var head: Node3D
@export var cam: Camera3D

var cur_recoil_rot: Vector3
var recoil_target: Vector3

var spawn_pos

enum swordStates {SWINGING, STABBING, BLOCKING, PAIRRYING, HIT, NONE}
var cur_swordState = swordStates.NONE

func _ready() -> void:
	pass
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	spawn_pos = global_position

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * Global.sense)
		cam.rotate_x(-event.relative.y * Global.sense)
		cam.rotation.x = clamp(cam.rotation.x, deg_to_rad(-75), deg_to_rad(75))
		

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Global.in_menu == false:
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = jump_vel
			print("jump")
			
		
		if Input.is_action_just_pressed("attack"):
			attack()
		
		
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = move_toward(velocity.x, direction.x * speed, acc * delta)
		velocity.z = move_toward(velocity.z, direction.z * speed, acc * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, fric * delta)
		velocity.z = move_toward(velocity.z, 0, fric * delta)


	if global_position.y <= -0.858:
		die()

	if Input.is_action_just_pressed("l_click"):
		$"head/cam_holder/Camera3D/weapon holder/sword/AnimationPlayer".play("swing")
		cur_swordState = swordStates.SWINGING

	move_and_slide()
	

func attack():
	pass
	for i in $head/recoil/Camera3D/equiped.get_children():
		if i.visible:
			if i.has_method("attack"):
				i.attack()

func recoil(target):
	recoil_target = target

func die():
	$AnimationPlayer.play("death")
	global_position = spawn_pos
	


func _on_h_slider_value_changed(value: float) -> void:
	pass # Replace with function body.


func _on_attack_hitbox_body_entered(body: Node3D) -> void:
	if body.has_method("hit"):
		if cur_swordState == swordStates.SWINGING:
			body.hit(self)
