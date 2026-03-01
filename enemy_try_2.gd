extends RigidBody3D

var speed = 5.0
var health = 100

enum swordStates {SWINGING, STABBING, BLOCKING, PARRYING, HIT, NONE}
var cur_swordState = swordStates.NONE

#func _physics_process(delta: float) -> void:
	## Add the gravity.
	##if not is_on_floor():
		##velocity += get_gravity() * delta
#
	#move_and_slide()
	

func hit(sender):
	if cur_swordState != swordStates.BLOCKING or cur_swordState != swordStates.PARRYING:
		cur_swordState = swordStates.HIT
		knockback(sender)


func knockback(sender, pushforce = 8):
	apply_central_impulse(global_position.direction_to(sender.global_position) * -pushforce)
	print("hit")
