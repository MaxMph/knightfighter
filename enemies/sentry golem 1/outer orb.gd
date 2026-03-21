extends StaticBody3D

signal destroyed
@export var sound: PackedScene = preload("res://audio/effects/rock_break_sound.tscn")
var shard = preload("res://shard.tscn")
@export var value:= 10
@export var rand = 2

func hit(sender):
	if sound != null:
		var new_sound = sound.instantiate()
		get_tree().get_first_node_in_group("world").add_child(new_sound)
		new_sound.global_position = global_position
		#new_sound.play()
		#if value != 0:
			#Global.money += randi_range(value - rand, value + rand)
			#Global.audio_manager.get_sound("money").play()
		for i in value:
			var new_shard = shard.instantiate()
			get_tree().get_first_node_in_group("world").add_child(new_shard)
			new_shard.global_position = global_position
	#sound.play()
	
	destroyed.emit()
	queue_free()
	
