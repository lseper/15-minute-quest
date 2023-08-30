class_name Necromancer extends Player
	
@export var seeking: Player
@export var necromancer_minion: PackedScene
@export var dark_spell : PackedScene

func _process(_delta):
	update_animation_parameters("parameters/idle/blend_position")
	
# override player inputs
func _input(event):
	pass

func _physics_process(delta):
	if state_machine.check_if_can_move():	
		velocity.x = speed * direction
	else:
		velocity.x = 0
	move_and_slide()
