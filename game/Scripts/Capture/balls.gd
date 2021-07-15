extends HBoxContainer

onready var balls = [
	$ball1, $ball2, $ball3, $ball4, $ball5, 
]

const enabled := Color.white
const disabled := Color(0.3, 0.3, 0.3, 0.5)

func set_balls_active(count: int) -> void:
	for i in len(balls):
		if i < count: balls[i].modulate = enabled
		else: balls[i].modulate = disabled
