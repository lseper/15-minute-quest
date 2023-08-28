class_name Player extends CharacterBody2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var state_machine: CharacterStateMachine = $CharacterStateMachine
var damageable_node : Damageable

var jump_velocity: int = -500

signal facing_direction_changed(facing_right: bool)

signal pickup_dropped(body: Node, pickup: PackedScene)

@export var speed: int = 400
# used for movement
var direction = 0
# used for directional attacks
var facing : int = 1
#var stab_velocity = 500
#var stab_velocity_decay = 10
	
func _ready():
	animation_tree.active = true
	damageable_node = $Damageable

func update_animation_parameters(animation_tree_parameter_path: String):
	animation_tree.set(animation_tree_parameter_path, direction)

func update_facing_direction():
	if $Damageable.health > 0 and state_machine.check_if_can_change_direction():
		if direction > 0:
			sprite.flip_h = false
		elif direction < 0:
			sprite.flip_h = true
		emit_signal("facing_direction_changed", not sprite.flip_h)

func _process(delta):
	update_animation_parameters("parameters/move/blend_position")

func _input(event):
	if state_machine.check_if_can_change_direction():
		if event.is_action_released("ui_left") && direction == -1 or event.is_action_released("ui_right") && direction == 1:
			direction = 0
		if Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_right"):
			direction = 0
		elif Input.is_action_pressed("ui_left"):
			direction = -1
			facing = -1
		elif Input.is_action_pressed("ui_right"):
			direction = 1
			facing = 1
		update_facing_direction()

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity
	if state_machine.check_if_can_move():	
		velocity.x = speed * direction
	move_and_slide()
	
func drop_pickup(drop: PackedScene):
	pickup_dropped.emit(self, drop)
