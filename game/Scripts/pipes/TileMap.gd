extends TileMap

const map_size := Vector2(7, 7)

export var start := Vector2(0, 0)
export var end   := map_size - Vector2(1, 1)

enum PipeType { Straight, Angle }
enum PipeRotation { Deg0, Deg90, Deg180, Deg270 }

var mouse_offset := Vector2(0, 0)
var mouse_in := false
const tile_size := 128.0
var current_cell := Rect2(0, 0, tile_size, tile_size)

var possible_paths = [
	[[0, true, false, true], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [1, false, true, true], [0, true, true, false], [0, true, true, false], [1, true, false, true], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [0, false, true, true], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [0, false, true, true], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [1, false, false, false], [0, false, false, false], [0, false, false, false], [1, true, true, false], [1, false, false, false], [0, false, false, false], [1, true, false, true], [0, true, false, true], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [0, false, true, true], [-1, false, false, false], [0, true, false, true], [1, false, true, true], [0, true, true, false], [0, true, true, false], [0, true, true, false], [1, true, true, false], [-1, false, false, false], [0, false, true, true]],
	[[0, true, false, true], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [1, false, true, true], [1, true, false, true], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [1, false, true, true], [1, true, false, true], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [1, false, true, true], [0, true, true, false], [0, true, true, false], [1, true, false, true], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [0, false, true, true], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [1, false, true, true], [1, true, false, true], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [0, true, false, true]],
	[[0, false, false, false], [0, false, false, false], [0, false, false, false], [0, false, false, false], [1, true, false, true], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [1, false, false, false], [0, false, false, false], [0, false, false, false], [1, true, true, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [0, false, true, true], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [1, false, true, true], [0, true, true, false], [0, true, true, false], [1, true, false, true], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [0, true, false, true], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [0, true, false, true], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [1, false, true, true], [0, false, false, false], [0, false, false, false]],
	[[0, false, false, false], [0, false, false, false], [0, false, false, false], [1, true, false, true], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [1, false, false, false], [0, false, false, false], [0, false, false, false], [1, true, true, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [0, false, true, true], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [1, false, true, true], [1, true, false, true], [-1, false, false, false], [1, false, false, false], [0, false, false, false], [0, false, false, false], [1, true, false, true], [-1, false, false, false], [0, false, true, true], [-1, false, false, false], [0, true, false, true], [-1, false, false, false], [-1, false, false, false], [0, false, true, true], [-1, false, false, false], [0, false, true, true], [-1, false, false, false], [0, true, false, true], [-1, false, false, false], [-1, false, false, false], [0, false, true, true], [-1, false, false, false], [1, false, true, true], [0, true, true, false], [1, true, true, false], [-1, false, false, false], [-1, false, false, false], [0, false, true, true]],
	[[0, true, false, true], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [0, false, true, true], [-1, false, false, false], [-1, false, false, false], [1, false, false, false], [0, true, true, false], [0, true, true, false], [1, true, false, true], [0, false, true, true], [-1, false, false, false], [-1, false, false, false], [0, true, false, true], [-1, false, false, false], [-1, false, false, false], [0, false, true, true], [0, false, true, true], [-1, false, false, false], [-1, false, false, false], [0, true, false, true], [-1, false, false, false], [-1, false, false, false], [0, false, true, true], [1, false, true, true], [0, false, false, false], [0, false, false, false], [1, true, true, false], [-1, false, false, false], [-1, false, false, false], [0, false, true, true], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [1, false, false, false], [1, true, true, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [1, false, true, true], [0, true, true, false]],
	[[0, true, false, true], [-1, false, false, false], [-1, false, false, false], [1, false, false, false], [0, true, true, false], [0, true, true, false], [1, true, false, true], [1, false, true, true], [0, true, true, false], [0, true, true, false], [1, true, true, false], [-1, false, false, false], [-1, false, false, false], [0, false, true, true], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [1, false, false, false], [0, false, false, false], [0, false, false, false], [1, true, true, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [0, true, false, true], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [1, false, false, false], [0, true, true, false], [1, true, true, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [0, false, true, true], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [-1, false, false, false], [1, false, true, true], [0, false, false, false], [0, false, false, false], [0, false, false, false], [0, false, false, false], [0, true, true, false]],
]

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	mouse_offset = get_parent().position
	make_random_path()
	fill_map()
	
func _process(_delta):
	# if the mouse is inside the window
	if mouse_in:
		# get the cell from the mouse position
		var mouse_pos = get_viewport().get_mouse_position() - mouse_offset
		var rel_pos = (mouse_pos / tile_size).floor()
		var cell = get_cell(rel_pos.x, rel_pos.y)
		
		# if it is a valid cell
		if cell != INVALID_CELL:
			current_cell.position = rel_pos * tile_size
			update()
			if Input.is_action_just_pressed("mouse_l"):
				if is_modifiable(rel_pos.x, rel_pos.y):
					rotate_cell(rel_pos.x, rel_pos.y)
					if(check_path()): print("path found")
					else: print("path not found")

func _notification(what):
	match what:
		NOTIFICATION_WM_MOUSE_ENTER:
			mouse_in = true
		NOTIFICATION_WM_MOUSE_EXIT:
			mouse_in = false

func _draw():
	draw_rect(current_cell, Color(0.8, 0.8, 0.1, 0.3))
	
func check_path():
	var x := 0
	var y := 0
	var wasx := 0
	var wasy := 0
	var r = get_cell_rotation(x, y)
	if r == PipeRotation.Deg0 or r == PipeRotation.Deg180:
		wasx = -1
	else:
		wasy = -1
	var count := 0
	
	while(count < 20):
		var res = get_next_pipe(x, y, wasx, wasy)
		if res.empty():
			return false
		else:
			wasx = x
			wasy = y
			x += res[0]
			y += res[1]
		if x == 6 and y == 6:
			return true
	
func get_next_pipe(x, y, wasx, wasy) -> PoolIntArray:
	var cell = get_cell(x, y)
	var rot = get_cell_rotation(x, y)
	var _result = Vector2.ZERO
	var FAILED = PoolIntArray()
	
	var UP    = [ 0, -1]
	var LEFT  = [-1,  0]
	var RIGHT = [ 1,  0]
	var DOWN  = [ 0,  1]
	
	if cell == PipeType.Straight:
		match rot:
			PipeRotation.Deg0, PipeRotation.Deg180:
				if y != wasy: 
#					print("-> ", [x, y, wasx, wasy, cell, rot])
					return FAILED
				return PoolIntArray([x - wasx, 0])
			PipeRotation.Deg90, PipeRotation.Deg270:
				if x != wasx: return FAILED
				return PoolIntArray([0, y - wasy])
	elif cell == PipeType.Angle:
		match rot:
			PipeRotation.Deg0:
				if wasx < x or wasy < y:  
#					print("-> ", [x, y, wasx, wasy, cell, rot])
					return FAILED
				if wasx > x: return PoolIntArray(DOWN)
				else: return PoolIntArray(RIGHT)
			PipeRotation.Deg90:
				if wasx > x or wasy < y:  
#					print("-> ", [x, y, wasx, wasy, cell, rot])
					return FAILED
				if wasx < x: return PoolIntArray(DOWN)
				else: return PoolIntArray(LEFT)
			PipeRotation.Deg180:
				if wasx > x or wasy > y:  
#					print("-> ", [x, y, wasx, wasy, cell, rot])
					return FAILED
				if wasx < x: return PoolIntArray(UP)
				else: return PoolIntArray(LEFT)
			PipeRotation.Deg270:
				if wasx < x or wasy > y:  
#					print("-> ", [x, y, wasx, wasy, cell, rot])
					return FAILED
				if wasx > x: return PoolIntArray(UP)
				else: return PoolIntArray(RIGHT)
		 
#	print("||-> ", [x, y, wasx, wasy, cell, rot])
	return FAILED

func get_cell_rotation(x, y):
	var transposed := is_cell_transposed(x, y)
	var flippedx   := is_cell_x_flipped(x, y)
	var flippedy   := is_cell_y_flipped(x, y)
	
	if flippedy and transposed:
		return PipeRotation.Deg270
	elif flippedx and flippedy:
		return PipeRotation.Deg180
	elif flippedx and transposed:
		return PipeRotation.Deg90
	else:
		return PipeRotation.Deg0

func make_random_path():
	var index: int = rng.randi() % len(possible_paths)
	print("path ", index)
	index = 5
	var path = possible_paths[index]
	
	var w := int(map_size.x)
	var h := int(map_size.y)
	
	var i = 0
	for y in h:
		for x in w:
			var p = path[i]
			set_cell(x, y, p[0], p[1], p[2], p[3])
			i += 1

func fill_map():
	var w := int(map_size.x)
	var h := int(map_size.y)
	
	for y in h:
		for x in w:
			if not is_modifiable(x, y):
				continue
			if get_cell(x, y) == -1:
				set_random_cell(x, y)
			else:
				set_random_rotation(x, y)

func set_random_cell(x, y):
	var tile: int = rng.randi() % 2
	var rot = get_random_rotation()
	set_cell(x, y, tile, rot[0], rot[1], rot[2])

func set_random_rotation(x, y):
	var tile = get_cell(x, y)
	var rot = get_random_rotation()
	set_cell(x, y, tile, rot[0], rot[1], rot[2])

func get_random_rotation():
	# 0 ->   0deg
	# 1 ->  90deg
	# 2 -> 180deg
	# 3 -> 270deg
	var rot: int = rng.randi() % 4
	match rot:
		0: return [false, false, false]
		1: return [true,  false, true]
		2: return [true,  true,  false]
		3: return [false, true,  true]

func rotate_cell(x, y):
	var cell := get_cell(x, y)
	var rot = get_cell_rotation(x, y)
	
	var flipx := false
	var flipy := false
	var transpose := false
	
	match rot:
		PipeRotation.Deg0:
			flipx = true
			transpose = true
		PipeRotation.Deg90:
			flipx = true
			flipy = true
		PipeRotation.Deg180:
			flipy = true
			transpose = true
		PipeRotation.Deg270:
			# go back to 0 degrees
			pass
	
	set_cell(x, y, cell, flipx, flipy, transpose)

# returns false if it is the top-left or bottom-right cell
func is_modifiable(x, y) -> bool :
	return not ((x == 0 and y == 0) or (x == 6 and y == 6))
