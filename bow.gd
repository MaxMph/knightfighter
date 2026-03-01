extends Node3D

@export var arrow: PackedScene

var pulled = 0
var pull_max = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func draw():
	pass

func shoot():
	var new_arrow = arrow.instantiate()
	new_arrow.global_rotation = global_position
