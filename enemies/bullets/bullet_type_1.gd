extends CharacterBody3D

#var spawn_pos: Transform3D
#var spawn_rot

var speed = 4.0
var dmg = 20

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#global_transform = spawn_transform
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	velocity = transform.basis * Vector3(0,0,-speed)
	move_and_slide()


func _on_timer_timeout() -> void:
	queue_free()


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.has_method("hit"):
		body.hit(dmg)
		queue_free()
