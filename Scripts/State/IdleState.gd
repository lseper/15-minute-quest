class_name IdleState extends State

func _init():
	pass

func handle_input(player: CharacterBody2D, player_animation: AnimatedSprite2D, input: InputEvent) -> State:
	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_left"):
		return null
	elif Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left"):
		return RunningState.new()
	elif Input.is_action_pressed("ui_accept"):
		return AttackingState.new()
	elif Input.is_action_just_pressed("ui_up"):
		return JumpingState.new(player.JUMP_SPEED)
	elif Input.is_action_just_pressed("ui_down"):
		return StabbingState.new()
	else:
		return null
		
func update(player: CharacterBody2D, player_animation: AnimatedSprite2D) -> State:
	return null

func enter(player: CharacterBody2D, player_animation: AnimatedSprite2D):
	print("going into idle state")
	player.velocity = Vector2.ZERO
	player_animation.play("idle")
