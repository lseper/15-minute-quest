class_name CharacterStateMachine extends Node

@export var character: CharacterBody2D
@export var current_state: State
@export var animation_tree: AnimationTree

var states: Array[State]

func is_valid_state(state: State):
	return states.has(state)

func check_if_can_move() -> bool:
	return current_state.can_move

func check_if_can_change_direction() -> bool:
	return current_state.can_change_direction
	
func on_state_interrupt_state(new_state: State):
	switch_states(new_state)

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is State:
			states.append(child)
			# TODO: Set states up with what they need to function
			child.character = character
			child.playback = animation_tree["parameters/playback"]
			# connect to interrupt signal
			child.connect("interrupt_state", on_state_interrupt_state)
		else:
			push_warning("Child" + child.name + " is not a State for CharacterStateMachine")
	current_state.on_enter()

func switch_states(new_state: State):
	if is_valid_state(new_state):
		if current_state != null:
			current_state.on_exit()
			current_state.next_state = null
		current_state = new_state
		current_state.on_enter()

func _physics_process(delta):
	if(current_state.next_state != null):
		switch_states(current_state.next_state)
	current_state.state_process(delta)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(event):
	current_state.state_input(event)


func _on_hit_interrupt_state(new_state):
	on_state_interrupt_state(new_state)
