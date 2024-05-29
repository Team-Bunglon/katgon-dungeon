extends Control
class_name MiniCam

@onready var minicam_viewport: SubViewport = $ViewportContainer/SubViewport

func _ready():
	minicam_viewport.world_2d = get_viewport().world_2d

func show_cam(pos_cam: Vector2):
	$ViewportContainer/SubViewport/Camera2D.global_position = pos_cam
	if $AnimationPlayer.is_playing(): $AnimationPlayer.stop()
	$AnimationPlayer.play("show")

