extends Node2D

export var remaining := 10
export var time := 30.0

onready var score_label = $GridContainer/score
onready var time_label  = $GridContainer/time

func _ready():
	update_text()

func _process(delta):
	time -= delta
	if time <= 0.0:
		print("game finished")
		time = 0.0
	update_time_text()
	
func update_score_text(): 
	score_label.text = "Remaining: %d" % remaining

func update_time_text():
	time_label.text = "Time remaining: %d" % time

func update_text():
	update_score_text()
	update_time_text()

func add_caught():
	remaining -= 1
	if remaining == 0:
		print("game finished")
	update_score_text()

func _on_Funnel_body_entered(_body):
	add_caught()
