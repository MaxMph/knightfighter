extends Node3D

var spin_speed = 1

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	$"outer orbs".rotation.y += spin_speed * delta
