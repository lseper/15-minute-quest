class_name JumpingState extends State

var initial_velocity: int

func _init(initial_velocity: int = -500):
	self.initial_velocity = initial_velocity
	
func handle_input(player: CharacterBody2D, player_animation: AnimatedSprite2D, input: InputEvent) -> State:
	if Input.is_action_pressed("ui_accept"):
		return AttackingState.new()
	return null
	
func update(player: CharacterBody2D, player_animation: AnimatedSprite2D) -> State:
	if player.is_on_floor():
		if player.velocity.x == 0:
			return IdleState.new()
		else:
			return RunningState.new()
	elif player.velocity.y < -player.JUMP_MAX_EPSILON:
		player_animation.play("jump_ascend")
		return null
	elif player.velocity.y > player.JUMP_MAX_EPSILON:
		player_animation.play("jump_descend")
		return null
	else:
		return null

func enter(player: CharacterBody2D, player_animation: AnimatedSprite2D):
	player_animation.play("jump_ascend")
	player.velocity.y = self.initial_velocity
	player_animation.flip_h = player.velocity.x < 0
		
