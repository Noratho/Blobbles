extends Node2D

const FOOD_SCENE := preload("res://food.tscn")
const BLOBBLE_SCENE := preload("res://blobble.tscn")

@onready var CAMERA_REF = $Camera
@onready var PAUSE_BTN_REF = $"UILayer/TopLeftUI/PauseButton"

@export_group("Configuration")
@export var starting_blobbles : int = 5
@export var starting_food : int = 0
@export_range(0, 1) var food_spawn_rate : float = 0.5
@export var startPaused : bool = false
@export_subgroup("Camera & Area")
@export var simulation_size : Vector2 = Vector2(5000, 2500)
@export var camera_speed : float = 20.0
@export var min_max_zoom : Vector2 = Vector2(0.5, 4.0)
# camera_zoom_speed is ia percentage zoom 
@export var camera_zoom_speed : float = 0.05

var rng = RandomNumberGenerator.new()
var camera_velocity : Vector2
#var camera_size : Vector2
var camera_zoom_velocity : Vector2

var food_arr : Array[Food] = []
var blobble_arr : Array[Blobble] = []

func _ready():
	if startPaused:
		pause(true)

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
	CAMERA_REF.zoom.x = clamp(CAMERA_REF.zoom.x, min_max_zoom.x, min_max_zoom.y)
	CAMERA_REF.zoom.y = clamp(CAMERA_REF.zoom.y, min_max_zoom.x, min_max_zoom.y)

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
	var new_food = FOOD_SCENE.instantiate()
	# do stuff to food here
	#add_child(new_food)
	#print("spawn_food")
	pass

func stop_zoom_btn():
	camera_zoom_velocity = Vector2(0, 0)
	
func zoom_from_btn(zoomIn : bool):
	if zoomIn:
		camera_zoom_velocity = Vector2(1, 1)
	else:
		camera_zoom_velocity = Vector2(-1, -1)

#TODO TEST
func pause(fromButton: bool = false):
	if fromButton:
		if get_tree().paused:
			PAUSE_BTN_REF.text = "Pause"
		else:
			PAUSE_BTN_REF.text = "Start"
	get_tree().paused = !get_tree().paused
