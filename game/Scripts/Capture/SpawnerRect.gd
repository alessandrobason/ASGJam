extends ColorRect

export(PackedScene) var molecule_scene
export(PackedScene) var co2_molecule_scene

export var max_spawn_time := 1.0
export var min_spawn_time := 0.5
var timer := 0.0
var rng = RandomNumberGenerator.new()

func _ready():
	if not Engine.editor_hint:
		rng.randomize()

func _process(delta):
	if not Engine.editor_hint:
		timer -= delta
		if timer <= 0.0:
			spawn()

func spawn():
	reset_timer()
	var type: int = rng.randi_range(0, 30)
	var scene
	if (type % 3) == 0: scene = co2_molecule_scene
	else: scene = molecule_scene
	
	var x = rng.randf_range(0, rect_size.x)
	var y = 0.0
	var rot = rng.randf_range(0.0, 360.0)
	
	var pos = Vector2(x, y)
	print("spawning at ", pos)
	
	var new_molecule = scene.instance()
	
	new_molecule.position = Vector2(x, y)
	new_molecule.rotation_degrees = rot
	
	add_child(new_molecule)

func reset_timer():
	timer = rand_range(min_spawn_time, max_spawn_time)
	print("new timer: ", timer)
