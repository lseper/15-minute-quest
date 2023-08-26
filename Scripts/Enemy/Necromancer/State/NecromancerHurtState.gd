class_name NecromancerHurtState extends State

@export var hurt_animation : String
@export var idle_state: NecromancerIdleState

func on_enter():
	playback.travel(hurt_animation)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func state_process(delta):
	pass

func _on_animation_tree_animation_finished(anim_name):
	if anim_name == hurt_animation:
		next_state = idle_state
