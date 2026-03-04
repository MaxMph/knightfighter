extends Node3D

var spawn_speed = 3
@export var ring: PackedScene = preload("res://enemies/bullets/slam ring.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	slam_loop()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func slam_loop():
	await get_tree().create_timer(spawn_speed).timeout
	$AnimationPlayer.play("slam")
	slam_loop()
	

func spawn(attack):
	var new_ring = ring.instantiate()
	#new_ring.speed = speed
	new_ring.global_position = global_position
	get_tree().root.add_child(new_ring)
