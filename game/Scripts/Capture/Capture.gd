extends Node2D

export var time := 120.0
export var count := 30

onready var score_text = $VBoxContainer/score
onready var time_text = $VBoxContainer/time

func _process(delta):
	time -= delta
	if time <= 0:
		print("game finished")
	update_text()

func _on_Collected():
	print("collected")
	count -= 1
	if count == 0:
		print("YESS")

func update_text():
	time_text.text = "Time %d" % time
	score_text.text = "Remaining %d" % count
