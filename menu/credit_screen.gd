extends Node2D
@onready var wait_time: float = 0.5
@onready var can_select: bool = false

func _ready():
	$Background.play("default")
	$Continue.visible = false
	$Transition.play("slide_out")

func _input(event):
	if event.is_action_pressed("action_main") and can_select:
		$Transition.play("slide_in")

func _on_transition_animation_finished(anim_name:StringName):
	if anim_name == "slide_in":
		get_tree().change_scene_to_file("res://menu/main_menu.tscn")

func _on_timer_timeout():
	can_select = true
	$TextPlayer.play("default")



