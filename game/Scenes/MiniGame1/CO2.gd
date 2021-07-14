extends KinematicBody2D
class_name molecule

# We want to create an upper limit to for the molecules velocity
export var maxVelocity:=		Vector2(4000, 400)

# Molecules will be ejected from the pipe with 0 vertical 
# velocity and a random horizontal velocity between 0 and max
#var velocity:= Vector2.ZERO
var vec:= Vector2.ZERO

# Constructor (kinda)
func _ready() -> void:
	

# Horizontal dampening, the molecules will be ejected
# from the pipe with some horizontal force, we want this
# force to be dampened quickly after ejections so the 
# movement of the molecules are predominantly in the 
# positive verticle axis, making them easier targets
#velocity.y = rand_range(0, maxVelocity.y)


# Rate at which the molecules will accelarate to max lift
export var lift:= 	300.0


var linearDampening:= 20

# This is a built in function to GoDot, re-defining it
# within a node will call it 30 - 60 times a second
# generally where you put movement and collision
func _physics_process(delta: float) -> void:
	# Apply lift * dt to velocity
	velocity.y += Lift * delta
	
	# This is a comparitor returning the smallest amount
	velocity.y = min(velocity.y, maxSpeed.y)
	
	
	# Move_and_slide returns a vec2 that handels collisions w/
	# other objects. Effectivly handel collision
	velocity = move_and_slide(velocity)
