class_name NecromancerMinion extends Player

@export var seeking : Player
@export var boost := 2.5

func _ready():
	animation_tree.active = true
	velocity = get_seeking_vector_normalized() * boost

func _input(event):
	pass
	
func get_seeking_vector_normalized():
	if seeking != null:	
		return (seeking.position - position).normalized()
	else:
		return Vector2.ZERO

func _physics_process(delta):
	var normalized_direction = get_seeking_vector_normalized()
	velocity += normalized_direction * boost
	if not state_machine.check_if_can_move():
		velocity = Vector2.ZERO
	move_and_slide()
