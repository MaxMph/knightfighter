extends CharacterBody3D

var max_speed = 1000
var speed = 20
var acc = 40
var rot_speed = 4

var rand_vol = 2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rotation = Vector3(randi(), randi(), randi())
	#velocity = Vector3(randf_range(-rand_vol, rand_vol), randf_range(-rand_vol, rand_vol), randf_range(-rand_vol, rand_vol))
	pass


#func _physics_process(delta: float) -> void:
	#var rot = rotation
	#rot_speed = 10 + velocity.length() * 2
	#look_at(get_tree().get_first_node_in_group("player").global_position)
	#rot.x =  move_toward(rot.x, rotation.x, delta * rot_speed)
	#rot.y =  move_toward(rot.y, rotation.y, delta * rot_speed)
	#rot.y =  move_toward(rot.y, rotation.y, delta * rot_speed)
	#rotation = rot
	##if rot_speed > 100:
		##rot_speed += 100 * delta
	#
	##speed = move_toward(speed, max_speed, )
	##if speed < max_speed:
		##speed += 600 * delta
		#
	#velocity = velocity.move_toward(-transform.basis.z * speed, acc * delta)
	#
	##velocity = -transform.basis.z * speed * delta
	#move_and_slide()

func _physics_process(delta: float) -> void:
	var rot = rotation
	#rot_speed = 10 + velocity.length() * 2
	look_at(get_tree().get_first_node_in_group("player").global_position)
	rot.x =  move_toward(rot.x, rotation.x, delta * rot_speed)
	rot.y =  move_toward(rot.y, rotation.y, delta * rot_speed)
	rot.y =  move_toward(rot.y, rotation.y, delta * rot_speed)
	rotation = rot
	
	speed += 1 * delta
	rot_speed += 1 * delta
	velocity = -transform.basis.z * speed
	move_and_slide()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.get_parent().is_in_group("player"):
		Global.money += 1
		Global.audio_manager.get_sound("money").play()
		queue_free()
