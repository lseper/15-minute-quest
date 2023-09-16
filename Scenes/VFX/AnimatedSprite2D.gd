class_name MegaSprite extends AnimatedSprite2D

@export var animations : Array[String] = []
# these two arrays need to be the same size!
@export var collision_shapes : Array[RectangleShape2D]
@export var animation_player : AnimationPlayer
@export var hitbox: CollisionShape2D

var curr_animation_index = 0

func switch_to_next_animation():
	if curr_animation_index < animations.size():
		animation_player.play(animations[curr_animation_index])
		hitbox.shape = collision_shapes[curr_animation_index]
		curr_animation_index += 1

# Called when the node enters the scene tree for the first time.
func _ready():
	switch_to_next_animation()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_animation_player_animation_finished(anim_name):
	switch_to_next_animation()
