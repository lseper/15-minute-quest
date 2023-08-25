extends State

@export var ground_state: State
@export var jump_ascending_animation : String
@export var jump_max_animation: String
@export var jump_descending_animation: String
@export var attack_state: State

@export var jump_max_epsilon: int

func attack():
	next_state = attack_state
	attack_state.return_state = self
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func on_enter():
	playback.travel(jump_ascending_animation)
	
func on_exit():
	if next_state == ground_state:
		pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func state_process(delta):
	if character.is_on_floor():
		next_state = ground_state
		return
	if character.velocity.y >= -jump_max_epsilon and character.velocity.y <= jump_max_epsilon:
		playback.travel(jump_max_animation)
	elif character.velocity.y < -jump_max_epsilon:
		playback.travel(jump_ascending_animation)
	elif character.velocity.y > jump_max_epsilon:
		playback.travel(jump_descending_animation)

func _on_sword_body_entered(body):
	# TODO: Change to abstract "MovableEntity" class
	if body is Player and get_parent().current_state == self:
		attack()
