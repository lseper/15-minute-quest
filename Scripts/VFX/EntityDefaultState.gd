class_name EntityDefaultState extends EntityState

@export var default_state : String
@export var initial_state : String = ""
@export var end_state : String = ""
@export var root_node : Node2D

func on_enter():
	if initial_state.length() > 0:
		playback.travel(initial_state)
	else:
		playback.travel(default_state)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func state_process(delta):
	pass

func _on_animation_tree_animation_finished(anim_name):
	if end_state.length() > 0:
		if anim_name == end_state:
			root_node.queue_free()
	else:
		if anim_name == default_state:
			root_node.queue_free()

func _on_timer_timeout():
	playback.travel(end_state)

func _on_hitbox_area_body_entered(body):
	if end_state.length() > 0:
		playback.travel(end_state)
	else:
		root_node.queue_free()
