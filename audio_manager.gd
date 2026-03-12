extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.audio_manager = self
	#print(Global.audio_manager.name)
	print("audio")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_sound(sound_name: String):
	for i in get_children():
		#if i is AudioStreamPlayer:
		if i.name == sound_name:
			return i
			#sound_name.play()
