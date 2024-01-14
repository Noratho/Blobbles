extends Node2D
class_name Blobble

@export_group("Blobble Stats")
@export var health: int = 1
@export var speed: float = 4.0

@onready var main_scene_node = get_tree().current_scene

var velocity : Vector2
var target: Node2D

# TODO In the future maybe add replication requirements outside of food?


func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move()

func replicate():
	pass


func move():
	position += velocity * speed
