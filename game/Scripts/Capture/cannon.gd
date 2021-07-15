extends Sprite

export(PackedScene) var droplet_scene
onready var power_bar = get_node("../Control/power_bar")
onready var bar_bg = get_node("../Control/bar_bg")
onready var balls_manager = get_node("../VBoxContainer/balls")

const max_angle := deg2rad(60)
const min_angle := -max_angle
const cannon_force := 100.0

const min_power := 80.0
const max_power := 900.0

const max_proj := 5
var proj_count := 0

var mouse_pos := Vector2(0, 0)

func _process(delta):
	update_mouse_pos()
	var angle = mouse_pos.angle_to(position) + (PI/2.0)
	
	rotation = clamp(-angle, min_angle, max_angle)
	
	if Input.is_action_just_pressed("mouse_l"):
		shoot()
	
	var scale_y := clamp(mouse_pos.length(), min_power, max_power)
	var rel := scale_y / (max_power - min_power)
	rel = clamp(rel, 0.0, 1.0)
	
	power_bar.color = lerp(Color.green, Color.red, rel)
	power_bar.rect_size.x = bar_bg.rect_size.x * rel

func update_mouse_pos() -> void:
	mouse_pos = get_global_mouse_position() - position

func shoot():
	if proj_count < max_proj:
		proj_count += 1
		update_balls()
		var droplet = droplet_scene.instance()
		droplet.position = position
		droplet.linear_velocity = mouse_pos
		
		var err = droplet.connect("free_proj", self, "_on_Free_Proj")
		if err: print("error: ", err)
		err = droplet.connect("collected", get_parent(), "_on_Collected")
		if err: print("error: ", err)
		
		get_parent().add_child(droplet)

func update_balls():
	balls_manager.set_balls_active(max_proj - proj_count)

func _on_Free_Proj():
	if proj_count > 0:
		proj_count -= 1
		update_balls()
