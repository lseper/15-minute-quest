extends State

@export var attack_node: String
# returns to whatever state it came from
var return_state: State

func attack_jump():
	character.velocity.y = character.jump_velocity

func on_enter():
	playback.travel(attack_node)
	
func on_exit():
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func state_input(event: InputEvent):
	if event.is_action_pressed("ui_up"):
		attack_jump()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_animation_tree_animation_finished(anim_name):
	if anim_name == attack_node:
		next_state = return_state
