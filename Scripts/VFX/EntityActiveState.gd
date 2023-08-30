class_name EntityActiveState extends EntityState

@export var active_animation : String
@export var root_node : Node2D

func on_enter():
	print("switching")
	playback.travel(active_animation)
	
func on_exit():
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func state_process(delta):
	pass

func _on_animation_tree_animation_finished(anim_name):
	if anim_name == active_animation:
		root_node.queue_free()
