class_name EnemySpawner extends Area2D

@onready var spawn_timer = $Timer
@onready var spawn_area = $CollisionShape2D
@export var enemy : PackedScene
@export var player: Player

@onready var x_width_half = int(spawn_area.shape.size.x / 2.0)
@onready var x_min = spawn_area.position.x - x_width_half
@onready var x_max = spawn_area.position.x + x_width_half

@onready var y = spawn_area.position.y + int(spawn_area.shape.size.y / 2.0)
@onready var spawn_ceiling = int(spawn_area.position.y - int(spawn_area.shape.size.y / 2.0))

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	# creates an instance of the scene
	var slime_instance : Slime = enemy.instantiate()
	if player != null:
		slime_instance.seeking = player
	slime_instance.color = randi_range(0, 6)
	var randx = randi_range(x_min, x_max)
	slime_instance.position = Vector2(randx, y)
	slime_instance.spawn_ceiling = spawn_ceiling
	self.add_child(slime_instance)
