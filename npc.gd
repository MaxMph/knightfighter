extends StaticBody3D

@export var dialogue_res: DialogueResource

@onready var balloon = preload("res://player/dialogue/balloon.tscn")

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass
	#print(Global.in_menu)

func interacted():
	#print("int")
	if Global.in_menu == false:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		var new_balloon = balloon.instantiate()
		add_child(new_balloon)
		new_balloon.start(dialogue_res, "start", [self])
		Global.in_menu = true

func dialogue_done():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
