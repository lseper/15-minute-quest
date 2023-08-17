class_name RunningState extends State

func _init():
	pass
	
func handle_input(player: CharacterBody2D, player_animation: AnimatedSprite2D, input: InputEvent) -> State:
	if (Input.is_action_just_released("ui_left") && player.direction == -1 and not Input.is_action_pressed("ui_right")) or ((Input.is_action_just_released("ui_right") && player.direction == 1 and not Input.is_action_pressed("ui_left"))):
		return IdleState.new()
	if (Input.is_action_pressed("ui_right") && player.direction == -1) or (Input.is_action_pressed("ui_left") && player.direction == 1):
		return IdleState.new()
	if Input.is_action_pressed("ui_up"):
		return JumpingState.new()
	if Input.is_action_pressed("ui_accept"):
		return AttackingState.new()
	return null
	
func update(player: CharacterBody2D, player_animation: AnimatedSprite2D) -> State:
	return null

func enter(player: CharacterBody2D, player_animation: AnimatedSprite2D):
	player.velocity.y = 0
	player.velocity.x = player.SPEED
	player_animation.play("run")
	
