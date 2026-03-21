extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("esc"):
		if visible == false:
			if Global.in_menu == false:
				open()
		else:
			close()

func open():
	show()
	Global.in_menu = true
	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	%sense.value = Global.sense

func close():
	hide()
	Global.in_menu = false
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Global.sense = %sense.value


func _on_resume_pressed() -> void:
	await get_tree().physics_frame
	close()

func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_fullscreen_pressed() -> void:
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		print("asdfasdf")
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
