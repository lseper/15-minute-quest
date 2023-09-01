class_name EntityAnticipationState extends EntityState

@export var anticipation_animation : String
@export var active_state : EntityState

func on_enter():
	playback.travel(anticipation_animation)
	
func on_exit():
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func state_process(delta):
	pass

func _on_animation_tree_animation_finished(anim_name):
	if anim_name == anticipation_animation:
		next_state = active_state
