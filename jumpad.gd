extends Node3D

@export var force = 40

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	#if body.is_in_group("player"):
	if body is RigidBody3D:
		#body.apply_central_impulse(Vector3.UP * force)
		if body.linear_velocity.y < 0:
			body.linear_velocity.y = 0
		body.linear_velocity.y += force
		print("bounce")
	
