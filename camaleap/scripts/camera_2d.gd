extends Camera2D

@export var target: Node2D
@export var smoothing_speed: float = 5.0

func _process(delta):
	if target:
		# Only follow vertical position
		global_position.y = lerp(global_position.y, target.global_position.y, delta * smoothing_speed)
