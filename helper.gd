extends Node


# 
func vec2_clamp(pos : Vector2, bounds : Vector2) -> Vector2:
	
	var output : Vector2 
	output.x = clamp(pos.x, bounds.x, bounds.y)
	output.y = clamp(pos.y, bounds.x, bounds.y)
	
	return output
