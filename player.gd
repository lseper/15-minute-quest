extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D
@onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var speed = 400
var current_anim = "idle"
var direction = 0
var jump_velocity = 500
var jump_max_epsilon = jump_velocity / 10
var stab_velocity = 500
var stab_velocity_decay = 10
var is_stabbing = false
var facing = 1

func _on_stab_timer():
	_animated_sprite.frame = 4
	
func _ready():
# do NOT loop the stab or attack animations
	var timer = $StabTimer
#	timer.timeout.connect(_animated_sprite.sprite_frames)

func _process(delta):
	var to_play = "idle"
	direction = 0
	if Input.is_action_pressed("ui_right"):
		to_play = "run"
		_animated_sprite.flip_h = false
		facing = 1
		direction = 1
	elif Input.is_action_pressed("ui_left"):
		to_play = "run"
		direction = -1
		_animated_sprite.flip_h = true
		facing = -1
	if Input.is_action_pressed("ui_accept"):
# this blocks itself (cannot repeat it once being done)
		to_play = "attack"
	if Input.is_action_pressed("ui_down"):
# this blocks itself (cannot repeat it once being done)
		to_play = "stab"
		is_stabbing = true
		direction = 0
		if _animated_sprite.frame >= 3:
			_animated_sprite.frame = 3
	if Input.is_action_just_released("ui_down"):
		velocity.x += facing * stab_velocity
		print("initiating stab with velocity", velocity, is_stabbing)
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y -= jump_velocity
	if not is_on_floor():
		if velocity.y < -jump_max_epsilon:
			to_play = "jump_ascend"
		elif velocity.y > jump_max_epsilon:
			to_play = "jump_descend"
		else:
			to_play = "jump_max"
#	if is_stabbing:
#		velocity.x += sign(velocity.x) * (-stab_velocity_decay)
#		print(velocity)
#		if abs(velocity.x) < stab_velocity_decay:
#			velocity.x = 0
#			is_stabbing = false
#	else:
	velocity.x = direction * speed
	current_anim = to_play
	_animated_sprite.play(to_play)
	
func _physics_process(delta):
	velocity.y += gravity
	move_and_slide()
