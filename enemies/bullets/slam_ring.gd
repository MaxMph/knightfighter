extends Node3D

var speed = 6
var dmg = 28

func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	scale.x += speed * delta
	scale.z += speed * delta
	scale.y += speed * delta
	position.y -= speed * delta / 4

func _on_timer_timeout() -> void:
	queue_free()    


func _on_area_3d_body_entered(body: Node3D) -> void:
	#if body.is_in_group("hitbox"):
	if body.has_method("hit"):
		body.hit(dmg)
		body.get_parent().linear_velocity.y = 28
		#get_tree().quit()
