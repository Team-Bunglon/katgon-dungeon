extends Camera2D

## How strong the camera shake strength woud be
@export var shake_strength: float = 0.0

## The bigger the value, the shorter the shake duration becomes
@export var shake_length : float = 0.0

@onready var rd1: Area2D = $"../Player1/RoomDetector1"
@onready var rd2: Area2D = $"../Player2/RoomDetector2"
@onready var room_name_label = get_tree().get_root().find_child("RoomNameLabel", true, false)

var rng := RandomNumberGenerator.new()
var shake_strength_current: float = 0.0

func shake_camera():
	shake_strength_current = shake_strength

func _process(delta):
	if shake_strength_current > 0:
		shake_strength_current = lerpf(shake_strength_current, 0, shake_length * delta)
		print(offset)
		offset = _random_offset()

func _random_offset() -> Vector2:
	return Vector2(
		rng.randf_range(-shake_strength_current, shake_strength_current),
		rng.randf_range(-shake_strength_current, shake_strength_current)
	)

func _on_room_detector_1_area_entered(area:Area2D):
	_move_camera(area)

func _on_room_detector_2_area_entered(area:Area2D):
	_move_camera(area)

func _move_camera(area: Area2D):
	# Code taken from Harrison Miller's code sample
	# https://github.com/Harrison-Miller/RoomBasedCamera/blob/master/Player.gd
	if area.name == "Area2D":
		room_name_label.text = area.get_parent().room_name
		var room = area.get_node("CollisionShape2D")
		var size = room.shape.extents*2

		var view_size = get_viewport_rect().size
		if size.y < view_size.y:
			size.y = view_size.y
		if size.x < view_size.x:
			size.x = view_size.x

		limit_top = room.global_position.y - size.y/2
		limit_left = room.global_position.x - size.x/2
		limit_bottom = limit_top + size.y
		limit_right = limit_left + size.x
		#debug_position()

func _debug_position():
	var all_position = {
		"top": limit_top,
		"bottom": limit_bottom,
		"left": limit_left,
		"right": limit_right
		}
	print(all_position)

