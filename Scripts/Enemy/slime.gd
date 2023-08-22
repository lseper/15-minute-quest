class_name Slime extends Player
# TODO: Change ^ to extend a base "Entity" class that both Player and Slime derive

@export var seeking : CharacterBody2D
# how strongly the slime seeks the player.
# 0.0 - 1.0 = avoids player
# 1.0 - 2.0 = seeks player
@export var seek_bias : float = 1.75
@export var color: SlimeColor = SlimeColor.GREY

@onready var collision_box : SlimeCollisionBox = $SlimeCollisionBox

enum SlimeColor {
	PINK,
	RED,
	YELLOW,
	BLUE,
	GREEN,
	BROWN,
	GREY
}

func change_direction(new_direction: int):
	direction = new_direction
	facing = new_direction
	update_facing_direction()

func move():
	if seeking != null:
# if in front, this will be positive, if behind, negative
		var position_relative_to_seeker = seeking.position.x - position.x
		var bias_direction = int(position_relative_to_seeker / abs(position_relative_to_seeker))
# TODO: for now, this is constant bias regardless of how FAR the slime is from
# the hero. Change it so that when it's closer, the bias is lessened
		var direction_f = randf_range(-1.0, 1.0) + (seek_bias * bias_direction)
		var new_direction: int = round(clamp(direction_f, -1.0, 1.0))
		change_direction(new_direction)
	else:
		var new_direction = randi_range(-1, 1)
		change_direction(new_direction)
		
# easy 25% encouragement to move towards player

func _ready():
	animation_tree.active = true
	

# override player inputs
func _input(event):
	pass

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity
	if state_machine.check_if_can_move():	
		velocity.x = speed * direction
	move_and_slide()


func _on_timer_timeout():
	move()

func _on_sprite_2d_frame_changed():
	var new_frame_coords = Vector2i(sprite.frame % sprite.hframes, color)
	if new_frame_coords != sprite.frame_coords:
		sprite.frame_coords = new_frame_coords


func _on_facing_direction_changed(facing_right):
	if facing_right:
		collision_box.position = collision_box.facing_right_position
	else:
		collision_box.position = collision_box.facing_left_position
