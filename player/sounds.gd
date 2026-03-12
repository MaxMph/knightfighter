extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$wind.volume_db = -60 + clamp(get_parent().linear_velocity.length() * 1.3, 0, 60)
	#$wind.volume_db = move_toward($wind.volume_db, -60 + clamp(get_parent().linear_velocity.length() * 1.2, 0, 60) , delta * 80)
	
	if (abs(get_parent().linear_velocity.x) + abs(get_parent().linear_velocity.z)) > 4 and $"../floorcast".is_colliding():
		var step_playing = false
		for i in $footsteps.get_children():
			for f in i.get_children():
				if f is AudioStreamPlayer:
					if f.playing == true:
						step_playing = true
						#print("stopped")
		if step_playing == false:
			if $"../floorcast".is_colliding():
				if $"../floorcast".get_collider().is_in_group("grass"):
					$footsteps/grass.get_child(randi_range(0, $footsteps/grass.get_child_count() - 1)).play()
				else:
					$footsteps/stone.get_child(randi_range(0, $footsteps/stone.get_child_count() - 1)).play()
