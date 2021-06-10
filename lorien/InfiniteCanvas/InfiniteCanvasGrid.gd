class_name InfiniteCanvasGrid
extends Node2D

# -------------------------------------------------------------------------------------------------
const GRID_SIZE := 25.0

# -------------------------------------------------------------------------------------------------
export var camera_path: NodePath
var color := Color("2b2d31") setget set_color, get_color
var _enabled: bool
var _camera: Camera2D

# -------------------------------------------------------------------------------------------------
func _ready():
	_camera = get_node(camera_path)
	_camera.connect("zoom_changed", self, "_on_zoom_changed")
	_camera.connect("position_changed", self, "_on_position_changed")
	get_viewport().connect("size_changed", self, "_on_viewport_size_changed")

# -------------------------------------------------------------------------------------------------
func enable(e: bool) -> void:
	set_process(e)
	visible = e

# -------------------------------------------------------------------------------------------------
func _on_zoom_changed(zoom: float) -> void: update()
func _on_position_changed(pos: Vector2) -> void: update()
func _on_viewport_size_changed() -> void: update()

# -------------------------------------------------------------------------------------------------
func set_color(c: Color) -> void:
	color = c
	update()

# -------------------------------------------------------------------------------------------------
func get_color() -> Color:
	return color

# -------------------------------------------------------------------------------------------------
func _draw() -> void:
	var size = get_viewport().size  * _camera.zoom
	var cam = _camera.offset
	var grid_size := GRID_SIZE
	
	# Vertical lines
	var start_index := int((cam.x - size.x) / grid_size) - 1
	var end_index := int((size.x + cam.x) / grid_size) + 1
	for i in range(start_index, end_index):
		draw_line(Vector2(i * grid_size, cam.y + size.y), Vector2(i * grid_size, cam.y - size.y), color)
	
	# Horizontal lines
	start_index = int((cam.y - size.y) / grid_size) - 1
	end_index = int((size.y + cam.y) / grid_size) + 1
	for i in range(start_index, end_index):
		draw_line(Vector2(cam.x + size.x, i * grid_size), Vector2(cam.x - size.x, i * grid_size), color)
