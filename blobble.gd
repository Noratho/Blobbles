extends Node2D
class_name Blobble

@export_group("Blobble Stats")
@export var health: int = 1
@export var speed: float = 20.0

var velocity : Vector2
var target: Node2D

# TODO In the future maybe add replication requirements outside of food?


func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func replicate():
	pass


func move():
	pass
