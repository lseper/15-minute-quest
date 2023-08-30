class_name NecromancerMinion extends Player

@export var seeking : Player
@export var boost := 2.5

func _ready():
	animation_tree.active = true

func _input(event):
	pass

func _physics_process(delta):
	move_and_slide()
