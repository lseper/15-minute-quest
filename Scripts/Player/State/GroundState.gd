class_name GroundState extends State

@export var air_state: State
@export var attack_state: State
@export var special_state: State
@export var death_state: State
@export var ground_animation: String
@export var player: Player

func jump():
	character.velocity.y = character.jump_velocity
	next_state = air_state

func attack():
	next_state = attack_state
	attack_state.return_state = self
	
func special():
	next_state = special_state
	
func death():
	next_state = death_state
	
# TODO: move ot NPC shop heal
func heal():
	player.damageable_node.hit(-5)

func state_input(event: InputEvent):
	if event.is_action_pressed("ui_up"):
		jump()
	if event.is_action_pressed("ui_down"):
		special()
	# TODO: NPC Shop heal
	if event.is_action_pressed("ui_accept"):
		heal()

func on_enter():
	playback.travel(ground_animation)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func state_process(delta):
	if not character.is_on_floor():
		next_state = air_state
		
func collision_is_damageable(body: Node):
	for child in body.get_children():
		if child is Damageable:
			return true
	return false

func _on_sword_body_entered(body):
	# TODO: change once abstract "MoveableEntity" created
	if body is Player and collision_is_damageable(body) and get_parent().current_state == self:
		attack()
