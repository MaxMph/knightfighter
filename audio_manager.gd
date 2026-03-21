extends Node

#var track_volumes:Dictionary = {}

var track_volumes = []
var cur_track = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.audio_manager = self
	#print(Global.audio_manager.name)
	#$metal_door.
	for i in $tracks.get_children():
		if i is AudioStreamPlayer:
			track_volumes.append(i.volume_db)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_sound(sound_name: String):
	for i in get_children():
		#if i is AudioStreamPlayer:
		if i.name == sound_name:
			return i
			#sound_name.play()
			

func change_track(track_name: String):
	cur_track = ""
	reset_track_vol()
	for i in $tracks.get_children():
		if i is AudioStreamPlayer:
			if i.name == track_name:
				#print("playing track")
				i.play()
				cur_track = track_name
				#fade_track(i, false)
				
			elif i.playing:
				fade_track(i)
			
		

func fade_track(track: AudioStreamPlayer, out = true):
	var fade_speed = 1.0
	
	if out:
		while track.volume_db > -75:
			track.volume_db = move_toward(track.volume_db, -80, get_process_delta_time() * fade_speed)
		track.stop()

func reset_track_vol():
	for i in $tracks.get_children():
		if i is AudioStreamPlayer:
			i.volume_db = track_volumes[$tracks.get_children().find(i)]
