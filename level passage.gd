extends Area3D

@export var level: PackedScene
@export var closed = false
@export var spawn_in = false



func _on_body_entered(body: Node3D) -> void:
	if closed == false:
		if body.is_in_group("player"):
			get_tree().change_scene_to_packed(level)


func _on_body_exited(body: Node3D) -> void:
	if closed:
		if spawn_in:
			if body.is_in_group("player"):
				closed = false
