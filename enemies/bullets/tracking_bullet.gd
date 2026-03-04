extends CharacterBody3D

var speed = 4.0

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if get_tree().get_first_node_in_group("player") != null:
		look_at(get_tree().get_first_node_in_group("player").global_position)
	velocity = transform.basis * Vector3(0,0,-speed)
	move_and_slide()


func _on_timer_timeout() -> void:
	queue_free()
