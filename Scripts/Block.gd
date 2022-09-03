"""
Partically inspired by ericdl's code on the Godot engine qa forum:
https://godotengine.org/qa/6615/dragging-object-in-godot-rigidbody2d-dragging
"""

extends RigidBody2D

const RIGIDBODY_SPEED = 1000
const TWELTH_ROOT_OF_TWO = 1.059463094359
const HANDPAN_DETUNE = 0.21

var is_active = false
var set_rotation
var is_dragging = false
var pointer_is_over = false
var user_press = false
var input_pos = Vector2(0,0)
var input_distance
var rigidbody_vector = 0

var pitches = []
var intervals = [0, 2, 3, 4, 5, 7, 8, 9, 10]


func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	rng.randi_range(0, 4)
	
	# Set random rotation
	rotation_degrees = rng.randi_range(-30, 30)
	set_rotation = rotation_degrees
	
	for x in range(0, len(intervals)):
		pitches.append(HANDPAN_DETUNE * (pow(TWELTH_ROOT_OF_TWO, x)))
	
	set_process_input(true)
	set_physics_process(true) 
	$AudioStreamPlayer2D.pitch_scale = pitches[rng.randi_range(0, 8)]


func _input(_event):
	if Input.is_action_just_released("ui_touch"):
		pointer_is_over = false


func _physics_process(delta):
	if pointer_is_over:
		mode = RigidBody2D.MODE_RIGID
		$CollisionShape2D.disabled = true
		input_pos = self.get_global_mouse_position()
		input_distance = self.position.distance_to(input_pos)
		is_dragging = true
		transform.rotated(set_rotation)
		
		if (input_distance <= 5.0):
			rigidbody_vector = 0
			self.set_linear_velocity(Vector2())
		else:
			rigidbody_vector = (input_pos - self.position).normalized()
			self.set_linear_velocity(rigidbody_vector * RIGIDBODY_SPEED * input_distance * delta)
		
		reset_all_blocks()
	else:
		mode = RigidBody2D.MODE_STATIC
		transform.rotated(set_rotation)
		$CollisionShape2D.disabled = false


func reset_all_blocks():
	for block in get_parent().get_children():
		block.set_inactive()


func toggle_active():
	if is_active:
		set_inactive()
	else:
		set_active()


func set_inactive():
	is_active = false
	$Sprite.modulate = Color(0.4, 0.4, 0.4)


func set_active():
	is_active = true
	$Sprite.modulate = Color(1, 1, 1)
	$AudioStreamPlayer2D.play()


func _on_Block_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_pressed("ui_touch"):
		pointer_is_over = true
