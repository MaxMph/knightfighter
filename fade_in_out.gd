extends ColorRect

var goal = 0
var fade_speed = 1

var goal_met = false
signal faded_out
signal faded_in


func _process(delta: float) -> void:
	color.a = move_toward(color.a, goal, fade_speed * delta)
	#color.a = move_toward(color.a, goal, fade_speed * delta)
	
	if goal_met == false and color.a == goal:
		goal_met = true
		if goal == 1:
			faded_out.emit()
		else:
			faded_in.emit()
		#emit_signal("faded_out")

func fade(speed = 1, fade_out = 1):
	#if fade_out == false:
	#color.a = move_toward(color.a, fade_out, speed)
	color.a = -fade_out
	goal_met = false
	goal = clamp(fade_out, 0, 1)
	fade_speed = speed
	print(goal)
	#await goal_met == true
	#return true
	#print("bleh")
	
