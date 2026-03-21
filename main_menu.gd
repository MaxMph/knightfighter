extends Control

@export var next_scene: String
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	if Global.audio_manager.cur_track != "calm_1":
		Global.audio_manager.change_track("calm_1")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	Global.audio_manager.get_sound("click_reverb").play()
	#$fade_in_out.fade(4, 1)
	#await Global.fade_in_out.fade(4, 1)
	#await $fade_in_out.faded_out
	#get_tree().change_scene_to_file("res://hub world.tscn")
	#get_tree().change_scene_to_packed(next_scene)
	Global.change_scene(next_scene, 0.2)


func _on_quit_pressed() -> void:
	get_tree().quit()
