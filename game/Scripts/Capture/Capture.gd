extends Node2D

export var time := 120.0
export var count := 30

onready var score_text = $VBoxContainer/score
onready var time_text = $VBoxContainer/time
onready var ending = $ending

func _ready():
	update_text()

func _process(delta):
	time -= delta
	if time <= 0:
		ending.open(false)
	update_text()

func _on_Collected():
	print("collected")
	count -= 1
	if count == 0:
		ending.open(true)

func update_text():
	time_text.text = "Time %d" % time
	score_text.text = "Remaining %d" % count
