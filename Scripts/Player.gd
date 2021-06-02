extends KinematicBody2D

var MAX_SPEED = 500
var ACCELARATION = 2000
var motion = Vector2.ZERO
var texture = load("res://Assets/Rock.png")
signal Gold
signal Rock

func _physics_process(delta):
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.is_in_group("Gold"):
			emit_signal("Gold")
		if collision.collider.is_in_group("Rock"):
			emit_signal("Rock")
			$Hearts.set_emitting(true)
			get_node("Sprite").set_texture(texture)
	var axis = get_input_axis()
	if axis == Vector2.ZERO:
		apply_friction(ACCELARATION * delta)
	else:
		apply_movement(axis * ACCELARATION * delta)
	motion = move_and_slide(motion)
	if motion != Vector2.ZERO:
		$Rocks.set_emitting(true)

func get_input_axis():
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return axis.normalized()

func apply_friction(amount):
	if motion.length() > amount:
		motion -= motion.normalized() * amount
	else:
		motion = Vector2.ZERO

func apply_movement(acceleration):
	if MAX_SPEED != 0:
		if !$Walk.playing:
			$Walk.play()
	motion += acceleration
	motion = motion.clamped(MAX_SPEED)
