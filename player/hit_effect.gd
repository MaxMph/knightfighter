extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func show_effect(intensity = 1.0, fade = 0.5):
	#var start_opacity = CanvasModulate.a #= Color(1,1,1, )
	modulate.a = intensity
	#await get_tree().process_frame
	#intensity = start_opacity
	await get_tree().process_frame
	intensity = move_toward(intensity, 0, fade * get_process_delta_time())
	if intensity > 0.04:
		show_effect(intensity, fade)
