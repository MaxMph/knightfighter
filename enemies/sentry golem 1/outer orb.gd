extends StaticBody3D

signal destroyed
@export var sound: PackedScene = preload("res://audio/effects/rock_break_sound.tscn")

func hit(sender):
	if sound != null:
		var new_sound = sound.instantiate()
		new_sound.global_position = global_position
		get_tree().get_first_node_in_group("world").add_child(new_sound)
		#new_sound.play()
		
	#sound.play()
	
	destroyed.emit()
	queue_free()
	
