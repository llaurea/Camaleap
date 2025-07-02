extends CharacterBody2D

@export var move_speed: float = 550.0
@export var jump_force: float = 600.0
@export var gravity: float = 1100.0

var direction: int = 1
var jumps_left: int = 2
var on_wall: bool = false

func _physics_process(delta):
	velocity.y += gravity * delta

	# Default horizontal movement
	velocity.x = direction * move_speed

	move_and_slide()

	# Reset if on floor
	if is_on_floor():
		jumps_left = 2
		on_wall = false

	# Check wall collisions
	on_wall = false
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var normal_x = collision.get_normal().x
		if abs(normal_x) > 0.1:
			if is_on_floor():
				# On ground, touching wall → flip direction immediately
				direction = -sign(normal_x)
				direction *= -1
			else:
				# In air → wall slide
				on_wall = true
				velocity.x = 0
				velocity.y = min(velocity.y, 300) # Slide down
			jumps_left = 2
			break

	# Jumping
	if Input.is_action_just_pressed("ui_accept"):
		if jumps_left > 0:
			velocity.y = -jump_force
			jumps_left -= 1

			# Only flip direction if jumping off a wall (air)
			if on_wall:
				direction *= -1
				on_wall = false

	$Sprite2D.flip_h = direction < 0

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == self:
		die()

func die():
	print("Player died!")
	get_tree().call_deferred("reload_current_scene")

func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body == self:
		get_tree().change_scene_to_file("res://scenes/GANHOU.tscn")
