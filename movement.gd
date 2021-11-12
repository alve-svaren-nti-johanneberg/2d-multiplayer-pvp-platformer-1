extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var last_vy = 0

var start_pos = Vector2.ZERO
var reset = false

# Called when the node enters the scene tree for the first time.
func _ready():
	start_pos = position
	pass # Replace with function body.

func is_grounded():
	var curr_vy = linear_velocity.y
	return curr_vy == 0 and last_vy == 0

func get_input(delta):
	var grounded = is_grounded()
	
	if Input.is_action_pressed("left"):
		apply_impulse(Vector2.ZERO, Vector2.LEFT * (3 if grounded else 1))
	if Input.is_action_pressed("right"):
		apply_impulse(Vector2.ZERO, Vector2.RIGHT * (3 if grounded else 1))
	if Input.is_action_just_pressed("jump") and grounded:
		apply_impulse(Vector2.ZERO, Vector2.UP * 45)
	
	if Input.is_action_just_pressed("respawn"):
		reset = true

func _integrate_forces(state):
	if reset:
		reset = false
		state.transform = Transform2D(0, start_pos)
		state.linear_velocity = Vector2.ZERO


func _physics_process(delta):
	last_vy = linear_velocity.y
	linear_velocity.x *= pow(.2, delta)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_input(delta)
#	apply_impulse(Vector2.ZERO, )
	 

