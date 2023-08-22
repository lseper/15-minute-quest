class_name State extends Node

@export var can_move: bool = true
@export var can_change_direction: bool = true
var next_state: State

var character: CharacterBody2D
var playback: AnimationNodeStateMachinePlayback

func state_input(event: InputEvent):
	pass
	
func state_process(delta):
	pass

func on_enter():
	pass

func on_exit():
	pass
