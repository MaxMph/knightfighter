extends RigidBody3D

var speed = 5.0
var health = 100

enum swordStates {SWINGING, STABBING, BLOCKING, PARRYING, HIT, IDLE}
var cur_swordState = swordStates.IDLE

#func _physics_process(delta: float) -> void:
	## Add the gravity.
	##if not is_on_floor():
		##velocity += get_gravity() * delta
#
	#move_and_slide()
	
	#if cur_swordState == swordStates.IDLE and $Timer.is_stopped():
		#$Timer.start()
	



func hit(sender):
	#if cur_swordState != swordStates.BLOCKING or cur_swordState != swordStates.PARRYING:
	if cur_swordState != swordStates.BLOCKING:
		cur_swordState = swordStates.HIT
		knockback(sender)
		health -= 10


func knockback(sender, pushforce = 8):
	apply_central_impulse(global_position.direction_to(sender.global_position) * -pushforce)
	print("hit")


func _on_timer_timeout() -> void:
	match randi_range(0, 2):
		0:
			cur_swordState = swordStates.IDLE
			$"head/weapon holder/sword/AnimationPlayer".play("idle")
		1:
			cur_swordState = swordStates.SWINGING
			$"head/weapon holder/sword/AnimationPlayer".play("swing")
			await $"head/weapon holder/sword/AnimationPlayer".animation_finished
			cur_swordState = swordStates.IDLE
			
		2:
			cur_swordState = swordStates.BLOCKING
			$"head/weapon holder/sword/AnimationPlayer".play("block")
			await get_tree().create_timer(randf_range(1.0, 4.0)).timeout
			cur_swordState = swordStates.IDLE
	
	$Timer.start()
