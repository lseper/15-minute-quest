class_name NecromancerMinion extends Player

@export var seeking : Player
@export var boost := 2.5



@onready var projectResolution := Vector2(ProjectSettings.get("display/window/size/viewport_width"), ProjectSettings.get("display/window/size/viewport_height"))

func _ready():
	animation_tree.active = true

func _input(event):
	pass

func _physics_process(delta):
	if position.x < 0 or position.x >= projectResolution.x or position.y < 0 or position.y >= projectResolution.y:
		velocity *= -0.75
	move_and_slide()
