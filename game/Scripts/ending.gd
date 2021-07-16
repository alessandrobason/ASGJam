tool
extends Control

export(String, MULTILINE) var success_text setget set_success_text
export(String, MULTILINE) var failure_text setget set_failure_text

onready var spr = $Sprite

const frame_time := 0.2
var cur_time := 0.0
const num_frame := 4
var cur_frame := 0

func _ready():
	if not Engine.editor_hint:
		visible = false
		
#	if not Engine.editor_hint:
#		open(false)

func _process(delta):
	if not Engine.editor_hint and visible:
		cur_time += delta
		while cur_time >= frame_time:
			cur_time -= frame_time
			cur_frame = (cur_frame + 1) % num_frame
			spr.frame = cur_frame
	
		if Input.is_action_just_pressed("exit"):
			close()

func open(success: bool) -> void:
	if success: set_text(success_text)
	else: set_text(failure_text)
	visible = true
	get_tree().paused = true

func close():
	if not Engine.editor_hint:
		get_tree().paused = false
		get_tree().quit()

func set_success_text(text):
	success_text = text
	set_text(text)
	
func set_failure_text(text):
	failure_text = text
	set_text(text)

func set_text(text):
	# for some reason godot (in editor) doesn't find the children?
	# so just check for good measure, this is never a problem at
	# runtime
	if len(get_children()) > 0:
		get_child(2).text = text
