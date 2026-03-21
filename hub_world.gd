extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.audio_manager.cur_track != "calm_1":
		Global.audio_manager.change_track("calm_1")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
