class_name AttackCollision extends CollisionShape2D

@export var facing_left_position: Vector2
@export var facing_right_position: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
