extends Area2D
class_name InteractionArea

#Variables
@export var action_name : String = "interact"
var interact : Callable = func():
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_body_entered(_body:Node2D):
	InteractionManager.register_area(self)

func _on_body_exited(_body:Node2D):
	InteractionManager.unregister_area(self)


