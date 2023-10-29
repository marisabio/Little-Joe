extends CharacterBody2D

#Variables
@export var move_speed = Vector2(100, 100)
var input_vector = Vector2.ZERO
var is_input_enabled = true

#Animation
@onready var anim_tree = $AnimationTree
@onready var anim_state = $AnimationTree.get("parameters/playback")

# Called when the node enters the scene tree for the first time.
func _ready():
	anim_tree.active = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	# This here is importante. Sometimes you want your player to not move. Very important.
	if is_input_enabled == true:

		# Input code
		var x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		var y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		input_vector = Vector2(x, y).normalized()

		# animation code
		if input_vector != Vector2.ZERO:
			anim_tree.set("parameters/Idle/blend_position", input_vector) #Idle
			anim_tree.set("parameters/Walk/blend_position", input_vector) #Walk
			anim_state.travel("Walk")
		else:
			anim_state.travel("Idle")
		
		# Movement code
		position += input_vector * move_speed * delta

