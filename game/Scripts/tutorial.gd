tool
extends Control

export(String, MULTILINE) var tutorial_text setget set_tutorial_text

onready var spr = $sprite

const frame_time := 0.2
var cur_time := 0.0
const num_frame := 4
var cur_frame := 0

func _ready():
	if not Engine.editor_hint:
		get_tree().paused = true

func _process(delta):
	if not Engine.editor_hint:
		cur_time += delta
		while cur_time >= frame_time:
			cur_time -= frame_time
			cur_frame = (cur_frame + 1) % num_frame
			spr.frame = cur_frame
	
		if Input.is_action_just_pressed("mouse_l"):
			close()

func close():
	if not Engine.editor_hint:
		get_tree().paused = false
		queue_free()

func set_tutorial_text(text):
	tutorial_text = text
	$inner_text.text = text
