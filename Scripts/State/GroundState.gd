class_name GroundState extends State

@export var jump_velocity = -750
@export var air_state: State
@export var attack_state: State
@export var special_state: State
@export var death_state: State
@export var ground_animation: String

func jump():
	character.velocity.y = jump_velocity
	next_state = air_state

func attack():
	next_state = attack_state
	attack_state.return_state = self
	
func special():
	next_state = special_state
	
func death():
	next_state = death_state

func state_input(event: InputEvent):
	if event.is_action_pressed("ui_up"):
		jump()
	if event.is_action_pressed("ui_accept"):
		attack()
	if event.is_action_pressed("ui_down"):
		special()
	if event.is_action_pressed("ui_cancel"):
		death()

func on_enter():
	playback.travel(ground_animation)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func state_process(delta):
	if not character.is_on_floor():
		next_state = air_state
