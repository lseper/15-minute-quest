class_name UI extends CanvasLayer

@onready var score_label : LabelAndNumber = $Score
@onready var health_bar : ProgressPercentageBar = $Health
@onready var combo_bar : ProgressPercentageBar = $Combo
@onready var coins_label : Counter = $Coins

@onready var score := 0:
	set(new_score):
		score = new_score
		_update_score_label()
		
@onready var coins := 0:
	set(new_coins):
		coins = new_coins
		_update_coins_label()
		
func _update_score_label():
	score_label.set_number(score)
	
func _update_coins_label():
	coins_label.set_count(coins)
	
func _update_health_bar(body: Node, damage_taken: int):
	health_bar.set_progress_by_change(-damage_taken)
	
func _update_combo_bar(combo_percentage: float):
	combo_bar.set_progress_by_percent(combo_percentage)
# Called when the node enters the scene tree for the first time.
# Called when the node enters the scene tree for the first time.
func _ready():
# do the following callback when this signal happens
	_update_score_label()

# run this as hook into things that emit collect()
func _on_collected(collectable : Pickup):
	if collectable:
		score += collectable.score_value
		coins += collectable.score_value

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
