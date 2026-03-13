extends Area3D

@export var destination: String
@export var starting_inside = false

#@export var file_string: String = ""
@export var dialogue_res: DialogueResource
@onready var balloon = preload("res://player/dialogue/balloon.tscn")

signal take_elivator(result)


func _ready() -> void:
	if starting_inside == true:
		Global.audio_manager.get_sound("metal_door").pitch_scale = 1.5
		Global.audio_manager.get_sound("metal_door").play()
	#DialogueManager.method_called.connect(_on_dialogue_method)

#func _on_dialogue_method(method_name: String):
	#if method_name == "set_entered_lab":
		#Globals.entered_lab = true

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		var new_balloon = balloon.instantiate()
		#get_tree().get_first_node_in_group("world").add_child(new_balloon)
		add_child(new_balloon)
		#new_balloon.start(dialogue_res, "start")
		new_balloon.start(dialogue_res, "start", [self])
		#new_balloon.method
		#new_balloon.
		Global.in_menu = true
		
		#var result = await take_elivator
		##await DialogueManager.method_called
		#if result == "yes":
			#get_tree().change_scene_to_file(file_string)
		
		#DialogueManager.show_dialogue_balloon(dialogue_res, "start")
		#get_tree().change_scene_to_file(file_string)

func change_scene():
	Global.audio_manager.get_sound("metal_door").pitch_scale = 1.0
	Global.audio_manager.get_sound("metal_door").play()
	Global.change_scene(destination, 0.4)
	#Global.audio_manager.get_sound("metal_door").pitch_scale = 1.5
	#Global.audio_manager.get_sound("metal_door").play()
