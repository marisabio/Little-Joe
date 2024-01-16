extends Node2D

#Variables
@onready var player = get_tree().get_first_node_in_group("player")
var active_areas = []
@export var can_interact = true

#Area register functions
func register_area(area: InteractionArea):
	active_areas.push_back(area)

func unregister_area(area: InteractionArea):
	var i = active_areas.find(area)
	if i != -1:
		active_areas.remove_at(i)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if active_areas.size() > 0 && can_interact:
		active_areas.sort_custom(_sort_by_distance_to_player)

# Multiple areas sorting function
func _sort_by_distance_to_player(area1, area2):
	var area1_to_player = player.global_position.distance_to(area1.global_position)
	var area2_to_player = player.global_position.distance_to(area2.global_position)
	return area1_to_player < area2_to_player

# Interation function
func _input(event):
	if event.is_action_pressed("interaction") && can_interact:
		if active_areas.size() > 0:
			can_interact = false
			await active_areas[0].interact.call()	
			can_interact = true