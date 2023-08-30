class_name SpellAreaOfEffect extends Area2D

@export var damage: int = 10

func _on_body_entered(body):
	for child in body.get_children():
		if child is Damageable:
			child.hit(damage)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
