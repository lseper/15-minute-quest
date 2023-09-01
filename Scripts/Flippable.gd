class_name Flippable extends Node

@export var hitbox : CollisionShape2D
@export var hitbox_right_position : Vector2
@export var hitbox_left_position : Vector2
@export var sprite : Sprite2D
@export var facing_right : bool

func turn_right():
	facing_right = true
	
func turn_left():
	facing_right = false

func set_position():
	if facing_right:
		hitbox.position = hitbox_right_position
		sprite.flip_h = false
	else:
		hitbox.position = hitbox_left_position
		sprite.flip_h = true

func _ready():
	set_position()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_position()
