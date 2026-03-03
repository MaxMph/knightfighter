extends Area3D

var up_force = 60
var acc = 40

var x: Array[RigidBody3D] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
#
#func body_entered():
	#pass
#
#func body_exited():
	#pass

func _physics_process(delta: float) -> void:
	for i in x:
		#x.linear_velocity.y = up_force
		i.linear_velocity.y = move_toward(i.linear_velocity.y, up_force, delta * acc)
		print(i)


func _on_body_entered(body: Node3D) -> void:
	if body is RigidBody3D:
		x.append(body)


func _on_body_exited(body: Node3D) -> void:
	x.erase(body)
