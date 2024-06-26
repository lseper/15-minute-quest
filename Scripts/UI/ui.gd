class_name UI extends CanvasLayer

@onready var score_label : LabelAndNumber = $Score
@onready var health_bar : ProgressPercentageBar = $Health
@onready var special_bar : ProgressPercentageBar = $Special
@onready var actual_combo_bar : ComboBarActual = $ComboBar
@onready var coins_label : Counter = $Coins
@onready var combo_timer : Timer = $ComboTimer
@onready var experience_to_next_level_label = $Experience
@onready var level_label = $Level

@onready var score := 0:
	set(new_score):
		score = new_score
		_update_score_label()
		
@onready var coins := 0:
	set(new_coins):
		coins = new_coins
		_update_coins_label()
		
@onready var combo := 1:
	set(new_combo):
		combo = new_combo
		_update_actual_combo_bar(combo)
		
@onready var experience_to_next_level := 100:
	set(new_experience_to_next_level):
		experience_to_next_level = new_experience_to_next_level
		_update_experience_to_next_level_label(experience_to_next_level)
		
@onready var level := 0:
	set(new_level):
		level = new_level
		_update_level(new_level)
		
func _update_score_label():
	score_label.set_number(score)
	
func _update_coins_label():
	coins_label.set_count(coins)
	
func _update_experience_to_next_level_label(new_experience_to_next_level: int):
	experience_to_next_level_label.set_number(new_experience_to_next_level)
	
func _update_level(new_level: int):
	level_label.set_number(new_level)
	
func _update_health_bar(body: Node, damage_taken: int):
	health_bar.set_progress_by_change(-damage_taken)
	
func _update_combo_bar(combo_percentage: float):
	special_bar.set_progress_by_percent(combo_percentage)
	
func _update_actual_combo_bar(new_combo: int):
	actual_combo_bar.set_combo(new_combo)
	
func _on_enemy_death(_experience: int):
	combo_timer.start()
	combo += 1
	
	
# Called when the node enters the scene tree for the first time.
# Called when the node enters the scene tree for the first time.
func _ready():
# do the following callback when this signal happens
	_update_score_label()
	_update_coins_label()
	_update_combo_bar(0.0)
	_update_actual_combo_bar(1)
	SignalBus.connect("on_enemy_death", _on_enemy_death)

# run this as hook into things that emit collect()
func _on_collected(collectable : Pickup):
	if collectable:
		score += int(collectable.score_value * 100 * actual_combo_bar.multiplier)
		coins += collectable.score_value

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	actual_combo_bar.set_progress_by_percent(combo_timer.time_left / combo_timer.wait_time)

func _on_combo_timer_timeout():
	combo_timer.stop()
	combo = 1

func _on_level_manager_experience_change(new_experience):
	_update_experience_to_next_level_label(new_experience)

func _on_level_manager_level_up(level):
	_update_level(level)
