tool
extends ColorRect

export(PackedScene) var molecule_scene
onready var funnel = get_node("../Funnel")

export var max_spawn_time := 1.5
export var min_spawn_time := 0.5
var timer := 0.0

func _ready():
	if not Engine.editor_hint:
		visible = false

func _process(delta):
	if not Engine.editor_hint:
		timer -= delta
		if timer <= 0.0:
			spawn()

func spawn():
	reset_timer()
	var y = rand_range(0.0, rect_size.y)
	print("spawning at %d" % y)
	
	var new_molecule = molecule_scene.instance()
	
	new_molecule.position = rect_position
	new_molecule.position.y += y
	var co2_mol = new_molecule.get_child(1)
	var error = funnel.connect("body_entered", co2_mol, "_on_Area2D_body_entered")
	assert(error == 0)
	
	get_parent().add_child(new_molecule)

func reset_timer():
	timer = rand_range(min_spawn_time, max_spawn_time)
	print("new timer: ", timer)
