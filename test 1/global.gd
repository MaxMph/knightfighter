extends Node

var sense = 0.001
var in_menu = false

var audio_manager
var fade_in_out

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(preload("res://audio_manager.tscn").instantiate())
	var new_fade = preload("res://player/fade_in_out.tscn").instantiate()
	add_child(new_fade)
	fade_in_out = new_fade
	await get_tree().create_timer(0.2).timeout
	fade_in_out.fade(1, -1)
	#get_tree().root.add_child(preload("res://audio_manager.tscn").instantiate())
	#print("audio")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func change_scene(scene:String, wait_time = 0.0):
	fade_in_out.fade(4, 1)
	await fade_in_out.faded_out
	get_tree().change_scene_to_file(scene)
	await get_tree().create_timer(wait_time).timeout
	#print("changed")
	fade_in_out.fade(3, -1)
	return
