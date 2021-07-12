extends Node2D
#
#export var height := 100.0 setget set_height
#export(PackedScene) var molecule_scene
#onready var funnel = get_node("../Funnel")
#
#export var max_spawn_time := 1.5
#export var min_spawn_time := 0.5
#var timer := 0.0
#
#func _ready():
#	print("height", height)
#	spawn()
#
#func _process(delta):
#	timer -= delta
#	if timer <= 0.0:
#		spawn()
#
#func spawn():
#	reset_timer()
#	var y = rand_range(0.0, height)
#	print("spawning at %d" % y)
#
#	var new_molecule = molecule_scene.instance()
#
#	new_molecule.position.y += y
#	var error = funnel.connect("body_entered", new_molecule, "_on_Area2D_body_entered")
#	assert(error == 0)
#
#	add_child(new_molecule)
#
#func reset_timer():
#	timer = rand_range(min_spawn_time, max_spawn_time)
#	print("new timer: ", timer)
#
#func set_height(h):
#	$SpawnerRect.set_height(h)
