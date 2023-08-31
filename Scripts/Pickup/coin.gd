class_name Coin extends Pickup

@onready var velocity := Vector2(0, -250)
@onready var animated_sprite = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	animated_sprite.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position += velocity * delta
	velocity.y += gravity * delta
	
func _on_body_entered(body: Node):
	super(body)
	# ensure the coin is falling when it hits the ground
	if body is StaticBody2D and velocity.y >= 0:
		velocity.y *= -1
#	mimic loss of kinetic energy to sound
		velocity.y *= 0.65
