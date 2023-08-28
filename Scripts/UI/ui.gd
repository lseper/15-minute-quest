class_name UI extends CanvasLayer

@export var score_label : Label
@export var health_bar : TextureProgressBar

@onready var score := 0:
	set(new_score):
		score = new_score
		_update_score_label()
		
func _update_score_label():
	score_label.text = str(score)
	
func _update_health_bar(body: Node, damage_taken: int):
	health_bar.value -= damage_taken

# Called when the node enters the scene tree for the first time.
# Called when the node enters the scene tree for the first time.
func _ready():
# do the following callback when this signal happens
	_update_score_label()

# run this as hook into things that emit collect()
func _on_collected(collectable : Pickup):
	if collectable:
		score += collectable.score_value

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
