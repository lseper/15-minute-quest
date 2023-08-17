class_name StabbingState extends State

var stab_timer: Timer
var initiated: bool

func _init():
	self.stab_timer = Timer.new()
	self.stab_timer.wait_time = 1.0
	self.initiated = false

func handle_input(player: CharacterBody2D, player_animation: AnimatedSprite2D, input: InputEvent) -> State:
	return null
	
func update(player: CharacterBody2D, player_animation: AnimatedSprite2D) -> State:
	if player_animation.frame == 4:
		player.velocity.x = player.STAB_SPEED * player.direction
		player_animation.pause()
	if player_animation.frame >= 5:
		return IdleState.new()
	return null

func enter(player: CharacterBody2D, player_animation: AnimatedSprite2D):
	player_animation.play("stab")
