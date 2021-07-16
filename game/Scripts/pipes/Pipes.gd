extends Node2D

export var time := 50.0
onready var time_label = $time

onready var ending = $ending

func _ready():
	update_text()

func _process(delta):
	time -= delta
	if time <= 0.0:
		ending.open(false)
	else:
		update_text()
	
func update_text():
	time_label.text = "Time Remaining: %d" % time
