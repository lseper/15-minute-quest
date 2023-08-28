class_name Coin extends Pickup

@onready var velocity := Vector2(0, -250)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position += velocity * delta
	velocity.y += gravity * delta
	
func _on_body_entered(body: Node):
	super(body)
	if body is Platform:
		velocity.y *= -1
#	mimic loss of kinetic energy to sound
		velocity.y *= 0.65
