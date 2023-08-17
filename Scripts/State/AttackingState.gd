class_name AttackingState extends State

var ATTACK_FRAMES: int = 18
var attack_frame: int

func _init():
	self.attack_frame = 0

func handle_input(player: CharacterBody2D, player_animation: AnimatedSprite2D, input: InputEvent) -> State:
	if Input.is_action_just_pressed("ui_up") and player.is_on_floor():
		return JumpingState.new()
# TODO: return to previous state upon attack completion
	return null
	
func update(player: CharacterBody2D, player_animation: AnimatedSprite2D) -> State:
	if self.attack_frame >= ATTACK_FRAMES:
		if player.is_on_floor():
			if player.velocity.x == 0:
				return IdleState.new()
			else:
				return RunningState.new()
		else:
			return JumpingState.new(player.velocity.y)
	self.attack_frame += 1
	return null

func enter(player: CharacterBody2D, player_animation: AnimatedSprite2D):
	player_animation.play("attack")
