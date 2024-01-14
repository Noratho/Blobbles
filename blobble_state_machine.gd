extends Node

@export var initial_state : BlobbleState
var current_state : BlobbleState
var states : Dictionary = {}

func _ready():
	for child in get_children():
		if child is BlobbleState:
			states[child.name.to_lower()] = child
			child.BlobbleTransition.connect(on_state_transition)
			
	if initial_state:
		initial_state.Enter()
		current_state = initial_state

func _process(delta):
	if current_state:
		current_state.Update(delta)

func _physics_process(delta):
	if current_state:
		current_state.Physics_Update(delta)

func on_state_transition(state : BlobbleState, new_state_name: String):
	if state != current_state:
		return
	
	var new_state : BlobbleState  = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if current_state:
		current_state.Exit()
	
	new_state.Enter()
