extends Node3D

#var triggers = []
var num = 0

func _ready() -> void:
	for i in get_children():
		if i.has_method("hit"):
			num += 1
			i.connect("destroyed", check_triggers)
			#triggers.append(i)
	
	#for i


func _process(delta: float) -> void:
	pass

func check_triggers():
	num -= 1
	if num == 0:
		trigger()

func trigger():
	$"../Area3D/AnimationPlayer".play_backwards("close")
