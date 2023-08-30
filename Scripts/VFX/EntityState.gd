class_name EntityState extends Node

var next_state: EntityState

var aoe: Area2D
var playback: AnimationNodeStateMachinePlayback

signal interrupt_entity_state(new_entity_state: EntityState)

func state_input(event: InputEvent):
	pass
	
func state_process(delta):
	pass

func on_enter():
	pass

func on_exit():
	pass
