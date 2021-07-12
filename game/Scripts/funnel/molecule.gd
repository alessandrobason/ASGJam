extends KinematicBody2D

onready var shape = $CollisionShape2D.shape;

# automatic movement data
const UP := Vector2(0.0, 1.0)
export var hor_velocity := 20.0
# player control data
export var up_velocity   := 60.0
export var down_velocity := 20.0
# destroying data
var is_captured := false
var scale_timer := 0.0
export var scale_speed := 2.0
var scale_was := Vector2(0.0, 0.0)
# molecule data
enum MoleculeType { Liquid, None, Co2 }
export(MoleculeType) var molecule_type = MoleculeType.None
# vertical drag, used with liquid molecules to drag them donward more than 
# co2 molecules
export var molecule_drag := 0.0

func _ready():
	scale_was = scale
	assert(molecule_type != MoleculeType.None)
	print("molecule type ", molecule_type)

func _process(delta):
	# if the molecule was captured, scale it down
	if is_captured:
		scale_timer += delta * scale_speed
		self.scale = lerp(scale_was, Vector2(0.0, 0.0), scale_timer)
		# when the scale is 0, remove the object and send signal that
		# the molecule has been caught
		if scale_timer >= 1.0:
			queue_free()

func _physics_process(_delta):
	var velocity = Vector2(
		hor_velocity, 
		0#-molecule_drag
	)
	
	# only move when the molecule isn't captured by the funnel
	if not is_captured:
		if Input.is_action_pressed("space_bar"):
			velocity.y -= up_velocity
		else:
			velocity.y += down_velocity
		
		if molecule_type == MoleculeType.Liquid:
			velocity.y *= -1.0
	
	var _result = move_and_slide(velocity, UP)

func caught():
	is_captured = true

func _on_Area2D_body_entered(body):
	body.caught()
