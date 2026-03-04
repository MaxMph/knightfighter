extends Node3D

var speed = 6

func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	scale.x += speed * delta
	scale.z += speed * delta
	scale.y += speed * delta
	position.y -= speed * delta / 4

func _on_timer_timeout() -> void:
	queue_free()    
