extends Node2D

const FOOD_SCENE := preload("res://food.tscn")
const BLOBBLE_SCENE := preload("res://blobble.tscn")

@onready var CAMERA_REF = $Camera
@onready var PAUSE_BTN_REF = $"UI Layer/HBoxContainer/Pause Button"

@export_group("Configuration")
@export var starting_blobbles : int
@export var starting_food : int
@export_range(0, 1) var food_spawn_rate : float
@export var isPaused : bool = false
@export_subgroup("Camera & Area")
@export var simulation_size : Vector2 = Vector2(5000, 2500)
@export var camera_speed : float = 20.0
@export var max_zoom : float = 4.0
# camera_zoom_speed is ia percentage zoom 
@export var camera_zoom_speed : float = 0.05

var rng = RandomNumberGenerator.new()
var camera_velocity : Vector2
#var camera_size : Vector2
var camera_zoom_velocity : Vector2

var food_arr : Array[food] = []

func _ready():
	pass

func _process(delta):
	if rng.randf_range(0.0, 1.0) > food_spawn_rate:
		spawn_food()
	update_camera()

func update_camera():
	var camera_size_half = (get_viewport_rect().size / CAMERA_REF.zoom )/2
	CAMERA_REF.position += camera_velocity * camera_speed
	var clamp_top = simulation_size - camera_size_half 
	CAMERA_REF.position.x = clamp(CAMERA_REF.position.x, 
		camera_size_half.x, clamp_top.x)
	CAMERA_REF.position.y = clamp(CAMERA_REF.position.y, 
		camera_size_half.y, clamp_top.y)
	
	CAMERA_REF.zoom += camera_zoom_velocity * (CAMERA_REF.zoom * camera_zoom_speed)
	CAMERA_REF.zoom.x = clamp(CAMERA_REF.zoom.x, 1, max_zoom)
	CAMERA_REF.zoom.y = clamp(CAMERA_REF.zoom.y, 1, max_zoom)

func _input(event):
	if event.is_action_pressed("pause"):
		pause()
	camera_velocity = Input.get_vector("camera_left", "camera_right",
	"camera_up", "camera_down")
	
	camera_zoom_velocity = Input.get_vector("camera_zoom_in", "camera_zoom_out",
	"camera_zoom_in", "camera_zoom_out")
		
#TODO perhaps add config to allow for modifying a 
# specific interval for food to spawn instead of
# it being based on chance
func spawn_food():
	#var new_food = FOOD_SCENE.new()
	# do stuff to food here
	#add_child(new_food)
	#print("spawn_food")
	pass


#TODO TEST
func pause(fromButton: bool = false):
	if fromButton:
		print("here")
		if get_tree().paused:
			PAUSE_BTN_REF.text = "Pause"
		else:
			PAUSE_BTN_REF.text = "Start"
	get_tree().paused = !get_tree().paused
