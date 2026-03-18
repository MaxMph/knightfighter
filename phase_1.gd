extends Node3D

#@export var trigger_nodes: Array[Node3D] = []
var done = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in $triggers.get_children():
		if i.has_signal("destroyed"):
			#i.destroyed.connect(check_triggers())
			i.connect("destroyed", check_triggers)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func check_triggers():
	print("check")
	if $triggers.get_children().size() <= 1:
		done = true
		$"../phase 2/AnimationPlayer".play("phase 2 start")
	#for i in nodes:
		#if i != null
