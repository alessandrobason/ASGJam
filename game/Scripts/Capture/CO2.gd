extends RigidBody2D

# We want to create an upper limit to for the molecules velocity
export var maxVelocity:=		Vector2(4000, 400)

# Rate at which the molecules will accelarate to max lift
export var liftRate = 50

# Constructor (kinda) 
func _ready() -> void:
	# Set initial position
	position = Vector2(5, 5)

# the molecules will be ejected from the pipe with a 
# horizontal impulse force this force will be dampened 
# quickly after ejections so the movement of the molecules
# are predominantly in the positive verticle axis
	apply_central_impulse(Vector2(rand_range(500, maxVelocity.x), 0))
	
	# Apply lify
	add_central_force(Vector2(0, liftRate))

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	

	if linear_velocity.y >= maxVelocity.y:
		add_central_force(Vector2(0, liftRate * delta))
