extends State

@export var idle_state: State
@export var special_charge_node: String
@export var special_release_node: String
@export var special_recover_node: String

@export var special_velocity: int = 800
@export var special_velocity_cooldown = 20

var is_charged : bool = false
var is_released: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func on_enter():
	playback.travel(special_charge_node)
	character.velocity.x = 0
	
func unleash():
	character.velocity.x = character.facing * special_velocity
	is_released = true
	is_charged = false
	playback.travel(special_release_node)

func state_input(event):
	if event.is_action_released("ui_down"):
		if is_charged:
			unleash()

func apply_friction():
	if character.velocity.x > 0:
		character.velocity.x -= special_velocity_cooldown
	else:
		character.velocity.x += special_velocity_cooldown

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_released:
		apply_friction()
		if (character.velocity.x <= 0 and character.facing > 0) or (character.velocity.x >= 0 and character.facing < 0):
			character.velocity.x = 0
			playback.travel(special_recover_node)
			is_released = false
			
func _on_animation_tree_animation_finished(anim_name):
#   finished charging the special
	if anim_name == special_charge_node:
		is_charged = true
#	if player unpresses charge up before it is finished
#	could additionally transition back to idle state as a "cancel"
		if not Input.is_action_pressed("ui_down"):
			unleash()
	elif anim_name == special_recover_node:
		next_state = idle_state
