class_name Player extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D
@onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# external scripts so godot doesn't shit itself
var State = load("res://Scripts/State/State.gd")
var IdleState = load("res://Scripts/State/IdleState.gd")
var AttackState = load("res://Scripts/State/AttackingState.gd")
var JumpingState = load("res://Scripts/State/JumpingState.gd")
var RunningState = load("res://Scripts/State/RunningState.gd")
var StabbingState = load("res://Scripts/State/StabbingState.gd")

var SPEED = 400
#var current_anim = "idle"
#var direction = 0
var JUMP_SPEED = -500
var JUMP_MAX_EPSILON = JUMP_SPEED / 10
var STAB_DURATION = 3.0
var STAB_SPEED = 1000
var direction = 0
#var stab_velocity = 500
#var stab_velocity_decay = 10
#var is_stabbing = false
#var facing = 1

#var actionable = true

@onready var state = JumpingState.new(gravity)

func _ready():
	state.enter(self, _animated_sprite)
	var stab_timer = $StabTimer
	stab_timer.timeout.connect(_on_stab_timer_timeout)

func _process(delta):
	var new_state = state.update(self, _animated_sprite)
	if new_state != null:
		state = new_state
		state.enter(self, _animated_sprite)
#	var to_play = "idle"
#	direction = 0
#	if Input.is_action_pressed("ui_right"):
#		to_play = "run"
#		_animated_sprite.flip_h = false
#		facing = 1
#		direction = 1
#	elif Input.is_action_pressed("ui_left"):
#		to_play = "run"
#		direction = -1
#		_animated_sprite.flip_h = true
#		facing = -1
#	if Input.is_action_pressed("ui_accept"):
## this blocks itself (cannot repeat it once being done)
#		to_play = "attack"
#	if Input.is_action_just_released("ui_down"):
#		velocity.x += facing * stab_velocity
#		print("initiating stab with velocity", velocity, is_stabbing)
#	if Input.is_action_just_pressed("ui_up") and is_on_floor():
#		velocity.y -= jump_velocity
#	if not is_on_floor():
#		if velocity.y < -jump_max_epsilon:
#			to_play = "jump_ascend"
#		elif velocity.y > jump_max_epsilon:
#			to_play = "jump_descend"
#		else:
#			to_play = "jump_max"
#	if Input.is_action_just_pressed("ui_down"):
#		to_play = "stab"
#		is_stabbing = true
#	velocity.x = direction * speed
#	current_anim = to_play
#	_animated_sprite.play(to_play)

func _input(event):
	var new_state = state.handle_input(self, _animated_sprite, event)
	if new_state != null:
		state = new_state
		state.enter(self, _animated_sprite)
	if event.is_action_released("ui_left") && direction == -1 or event.is_action_released("ui_right") && direction == 1:
		direction = 0
	if Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_right"):
		direction = 0
	elif Input.is_action_pressed("ui_left"):
		direction = -1
		_animated_sprite.flip_h = true
	elif Input.is_action_pressed("ui_right"):
		direction = 1
		_animated_sprite.flip_h = false
	elif Input.is_action_just_pressed("ui_down"):
# TODO: make this actually point the correct direction
		direction = 1
		$StabTimer.start()
	
func _physics_process(delta):
	velocity.y += gravity
	velocity.x = SPEED * direction
	move_and_slide()

func _on_stab_timer_timeout():
	_animated_sprite.play()
