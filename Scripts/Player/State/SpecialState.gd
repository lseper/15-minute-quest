class_name SpecialState extends State

@export var idle_state: State
@export var special_charge_node: String
@export var special_release_node: String
@export var special_recover_node: String

@export var special_velocity: int = 1500
@export var special_velocity_friction = 20
@export var max_charge_time: int = 2000
@export var charge_rate: float = 2.0

var charge_power: int = 0
var charge_started: int
var is_charged: bool = false
var is_released: bool = false

var total_charge_amount := 1.0

signal combo_charge(combo_percentage : float)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func on_enter():
	playback.travel(special_charge_node)
	character.velocity.x = 0
	charge_power = 0
	charge_started = Time.get_ticks_msec()
	is_charged = false

func on_exit():
	is_charged = false
	is_released = false
	self.can_change_direction = true
	charge_power = 0
	combo_charge.emit(charge_power)
	
func unleash():
	is_released = true
	is_charged = false
	self.can_change_direction = false
	character.velocity.x = (float(clamp(charge_power, 0, max_charge_time)) / float(max_charge_time)) * character.facing * special_velocity
	charge_power = 0
	playback.travel(special_release_node)

func state_input(event):
	if event.is_action_released("ui_down"):
		if is_charged and not is_released:
			unleash()

func apply_friction():
	if character.velocity.x > 0:
		character.velocity.x -= special_velocity_friction
	else:
		character.velocity.x += special_velocity_friction

func charge_up():
	var curr_progress = Time.get_ticks_msec() - charge_started
	charge_power = curr_progress * charge_rate
	combo_charge.emit(float(charge_power) / max_charge_time)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func state_process(delta):
	if is_released:
		apply_friction()
		if (character.velocity.x <= 0 and character.facing > 0) or (character.velocity.x >= 0 and character.facing < 0):
			character.velocity.x = 0
			playback.travel(special_recover_node)
			is_released = false
	else:
		if not playback.get_current_node() == special_recover_node:	
			charge_up()
			
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
