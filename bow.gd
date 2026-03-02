extends Node3D

@export var arrow: PackedScene

var drawed = 0
var draw_max = 100
var draw_speed = 75

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if Input.is_action_pressed("l_click"):
		draw(delta)
	if Input.is_action_just_released("l_click"):
		if drawed > 10:
			shoot()
	
	$ColorRect/ProgressBar.value = drawed
	
	


func draw(delta):
	drawed += draw_speed * delta
	if drawed > draw_max:
		drawed = draw_max

func shoot():
	var new_arrow = arrow.instantiate()
	#new_arrow.global_position = global_position
	#new_arrow.global_rotation = global_rotation
	new_arrow.spawn_transform = global_transform
	new_arrow.speed_mult = 1 - (draw_max - drawed) / 100
	get_tree().root.add_child(new_arrow)
	drawed = 0
