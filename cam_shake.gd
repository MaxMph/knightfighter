extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#pass # Replace with function body.
	#shake(1, 0, 2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func shake(intensity = 1.0, fade = 0.4, dur = 0.5):
	var start_rot = rotation
	rotation.x += deg_to_rad(randf_range(0.0, 1.0) * intensity)
	rotation.y += deg_to_rad(randf_range(0.0, 1.0) * intensity)
	rotation.z += deg_to_rad(randf_range(0.0, 1.0) * intensity)
	await get_tree().process_frame
	rotation = start_rot
	dur = dur - get_process_delta_time()
	intensity = move_toward(intensity, 0, fade * get_process_delta_time())
	if intensity < 0.05:
		dur = 0.0
	if dur > 0:
		rotation = Vector3.ZERO
		shake(intensity, fade, dur)
