extends StaticBody3D

@export var bullet_scene: PackedScene

@export var random_shooting = false
@export var forward_shooting = false
@export var spiral_shooting = false
@export var follow_shooting = false

@export var shootspeed = 0.2

@export var spiral_speed = 30

var time = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if random_shooting:
		bullet_call("random", shootspeed)
	if forward_shooting:
		bullet_call("forward", shootspeed)
	if spiral_shooting:
		bullet_call("spiral", shootspeed)
	if follow_shooting:
		bullet_call("follow", shootspeed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta

func bullet_call(type, interval):
	await get_tree().create_timer(interval).timeout
	#random(bullet_scene)
	match type:
		"random":
			random(bullet_scene)
		"forward":
			forward(bullet_scene)
		"spiral":
			spiral(bullet_scene)
		"follow":
			follow(bullet_scene)
	bullet_call(type, interval)

func spiral(bullet):
	var new_bullet = bullet_scene.instantiate()
	new_bullet.global_position = global_position
	new_bullet.rotation_degrees.y = time * spiral_speed
	#new_bullet.rotation_degrees = Vector3(randf_range(-60, 60), randf_range(-180, 180), randf_range(-60, 60))
	get_tree().root.add_child(new_bullet)


func follow(bullet):
	var new_bullet = bullet_scene.instantiate()
	new_bullet.global_position = global_position
	#new_bullet.rotation = global_position.direction_to(get_tree().get_first_node_in_group("player").global_position)
	
	get_tree().root.add_child(new_bullet)
	new_bullet.look_at(get_tree().get_first_node_in_group("player").global_position)

func random(bullet):
	var new_bullet = bullet_scene.instantiate()
	#new_bullet.rotation_degrees = Vector3(randf_range(-180, 180), randf_range(-180, 180), randf_range(-180, 180))
	#new_bullet.global_rotation.y = randi()
	#new_bullet.rotation_degrees = Vector3(randf_range(-180, 180), randf_range(-180, 180), randf_range(-180, 180))
	new_bullet.global_position = global_position
	#new_bullet.rotation.y = deg_to_rad(randi_range(-180, 180))
	new_bullet.rotation_degrees = Vector3(randf_range(-60, 60), randf_range(-180, 180), randf_range(-60, 60))
	get_tree().root.add_child(new_bullet)
	#print("shot")

func forward(bullet):
	var new_bullet = bullet_scene.instantiate()
	new_bullet.global_position = global_position
	new_bullet.rotation = global_rotation
	#new_bullet.rotation_degrees = Vector3(randf_range(-60, 60), randf_range(-180, 180), randf_range(-60, 60))
	get_tree().root.add_child(new_bullet)
