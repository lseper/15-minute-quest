extends CharacterBody2D



@onready var _animation_player = $AnimationPlayer
@onready var _idle = $"Idle"
@onready var _run = $"Run"

var speed = 400

# bit of a hack right now, eventually customize the sprites with overhaul to character
# load the animations all as one sprite in a combined spritesheet, then setup all 
# animations with AnimationPlayer, then do state logic with AnimationTree
@onready var states = {
	"idle": _idle,
	"run": _run
}

func _hide_all_animations():
	for anim in states.values():
		anim.hide()

func _change_animation(new_animation: String):
	if states.has(new_animation):
		var anim_to_show = states.get(new_animation)
		_animation_player.play(new_animation)
		_hide_all_animations()
		anim_to_show.show()
		_animation_player.advance(0)
	else:
		print("new animation %s not found :(" % new_animation)

func turn_player(is_right: bool):
	for anim in states.values():
		anim.set_flip_h(is_right)

func _process(delta):
	var direction = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		turn_player(false)
		_change_animation("run")
		direction = Vector2.RIGHT
	elif Input.is_action_pressed("ui_left"):
		turn_player(true)
		_change_animation("run")
		direction = Vector2.LEFT
	else:
		_change_animation("idle")
	var velocity = direction * speed
	position += velocity * delta
