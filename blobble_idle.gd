extends BlobbleState
class_name BlobbleIdle

@onready var blobble : Blobble = get_parent().get_parent()
var wander_time : float

func randomize_wander():
	blobble.velocity = Vector2(randi_range(-1, 1), randi_range(-1, 1)).normalized()
	wander_time = randf_range(1, 3)

func Enter():
	randomize_wander()

func Update(delta):
	if wander_time > 0:
		wander_time -= delta
	else:
		randomize_wander()

#func Physics_Update(delta):
	##velocity 
	#pass
