class_name VariantSpell extends Area2D

@export var damage: int = 10
@export var velocity : Vector2 = Vector2(0, 0)
@onready var sprite := $AnimatedSprite2D
@onready var hitbox := $Hitbox
@export var initially_faces_right := true

func _on_body_entered(body):
	for child in body.get_children():
		if child is Damageable:
			child.hit(damage)

func turn_right():
	if initially_faces_right:
		sprite.flip_h = false
	else:
		sprite.flip_h = true
		
func turn_left():
	if initially_faces_right:
		sprite.flip_h = true
	else:
		sprite.flip_h = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if velocity.x > 0:
		hitbox.position = hitbox.right_hitbox_position
		turn_right()
	else:
		hitbox.position = hitbox.left_hitbox_position
		turn_left()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position += velocity * delta

func _on_animation_player_animation_finished(anim_name):
	queue_free()
