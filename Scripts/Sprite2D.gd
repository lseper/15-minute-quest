extends Sprite2D

var speed = 400
var angular_speed = PI

func _on_timer_timeout():
	visible = not visible

# Called when the node enters the scene tree for the first time.
func _ready():
	var timer = $"Timer"
#	run this callback when the timer times out	timer.timeout.connect(_on_timer_timeout)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	var direction = 0
#	var velocity = Vector2.ZERO
#	if Input.is_action_pressed("ui_left"):
#		direction = -1
#	if Input.is_action_pressed("ui_right"):
#		direction = 1
#	if Input.is_action_pressed("ui_up"):
#		velocity = Vector2.UP.rotated(rotation) * speed
#	rotation += angular_speed * direction * delta
#	position += velocity * delta
	rotation += angular_speed * delta
	var velocity = Vector2.UP.rotated(rotation) * speed
	position += velocity * delta


func _on_button_pressed():
	# sets whether _process should be evaluated or not
	set_process(not is_processing())
	pass # Replace with function body.
