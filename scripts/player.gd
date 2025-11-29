extends CharacterBody3D

#Health and Stamina
@export var Health = 100
@export var Stamina = 50

#physics variables
var speed = 0
const WALK_SPEED = 5.0
const SPRINT_SPEED = 10.0
const CROUCH_SPEED = 3.0
const JUMP_VELOCITY = 4.5 * 2
const SENSITIVITY = 0.003

var SPRINT_MULT = 1
var CROUCH_MULT = 1

var GRAVITY = 9.8 * 10
var can_sprint = true
var is_crouching = false;

#bobbing variables
const BOB_FREQUENCY = 2.0
const BOB_AMPLITUDE = 0.08
var time_bob = 0.0

#fov variables
const BASE_FOV = 75.0
const FOV_CHANGE = 1.5

var INVENTORY = []

@onready var head = $Head
@onready var camera = $Head/Camera3D
@onready var pcollision = $CollisionShape3D

#puts mouse in captured mode
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

#camera work, making sure you cannot cartwheel and go mental
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-50), deg_to_rad(75))

func _Damage(Damage: float) -> void:
	Health -= Damage
	
func _Remove_stamina(Stamina_removed: float) -> void:
	if(Stamina > 0):
		Stamina -= Stamina_removed

func _Regain_stamina(Stamina_regained: float) -> void:
	if(Stamina < 50) and is_on_floor():
		Stamina += Stamina_regained

func _physics_process(delta: float) -> void:
	var tween = get_tree().create_tween();
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	#Handle sprint
	var input_dir := Input.get_vector("left", "right", "up", "down")
	
	if input_dir != Vector2.ZERO:
		speed = WALK_SPEED * SPRINT_MULT * CROUCH_MULT
		time_bob += delta * velocity.length() * float(is_on_floor())
	if Input.is_action_pressed("sprint") and can_sprint and Stamina > 0 and is_on_floor():
		SPRINT_MULT = 2.0
		_Remove_stamina(0.2);
		#proper head bobbing
	else:
		_Regain_stamina(0.1)
		SPRINT_MULT = 1.0
		
	#Handle crouch
	if Input.is_action_pressed("crouch"):
		tween.tween_property($CollisionShape3D, "scale:y", 0.2, 1.0)
		SPRINT_MULT = 1
		CROUCH_MULT = 0.25
		can_sprint = false
	else:
		CROUCH_MULT = 1
		scale.y = 1 
		tween.tween_property($CollisionShape3D, "scale:y", 1, 1.0)
		can_sprint = true
		
	if Input.is_action_just_pressed("pain"):
		if Health > 0:
			_Damage(10)
		
	if Input.is_action_just_pressed("heal"):
		if Health < 100:
			Health += 10
			
	if Input.is_action_just_pressed("close"):
		get_tree().quit()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			#slight intertia - makes you not immediately stop when not walking
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 7)
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 7)
	else:
		#slight inertia - makes you not immediately stop when not giving any input when jumping
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 2)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 2)
		
	

	#further fov when sprinting
	var velocity_clamped = clamp(velocity.length(), 0.5, SPRINT_SPEED * 2)
	var target_fov = BASE_FOV + FOV_CHANGE * velocity_clamped
	camera.fov = lerp(camera.fov, target_fov, delta * 8)

	move_and_slide()
	camera.transform.origin = _headbob(time_bob)
#"pos" instead of "position" due to an apparently already existing variable within GODOT
#also no clue why do I have to put this function here - I wanted it closer to other functions
#and shit just didn't work with "delta" for "time_bob" in proper head bobbing fragment
func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQUENCY) * BOB_AMPLITUDE
	pos.x = cos(time * BOB_FREQUENCY / 2) * BOB_AMPLITUDE
	return pos
