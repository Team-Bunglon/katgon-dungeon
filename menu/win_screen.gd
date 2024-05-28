extends Control

@export var cherry_text: String = "as well as {c} out of {c_all} golden cherries"
@export var play_time_text: String = "Game time: {t}"
@export var survive_time_text: Dictionary = {
	0: "One month",
	1: "One month and one week",
	2: "One and a half months",
	3: "One month and three weeks",
	4: "Two months",
	5: "Two months and one week",
	6: "Two and a half months",
	7: "Two months and three weeks",
	8: "Three months",
	9: "Three months and one week",
	10: "Three and a half months",
	11: "Three months and three weeks",
	12: "Four months",
}
@onready var can_select: bool = false

func _ready():
	Music.play("Menu", false)
	$Background.play("default")
	$EndSprite.play("default")
	$Continue.visible = false
	$Cherry.text = cherry_text.format({
		"c": str(PlayerVar.cherry),
		"c_all": str(PlayerVar.cherry_all),
	})
	if PlayerVar.cherry < 0:
		$SurviveTime.text = "You are in debt"
	elif PlayerVar.cherry < len(survive_time_text):
		$SurviveTime.text = survive_time_text[PlayerVar.cherry]
	else:
		$SurviveTime.text = "Four months at least"
	$PlayTime.text = play_time_text.format({
		"t": PlayerVar.final_time
	})
	$Transition.play("slide_out")

func _input(event):
	if event.is_action_pressed("ui_accept") and can_select:
		Sound.play("MenuSelect")
		$Transition.play("slide_in")
	
func _on_transition_animation_finished(anim_name:StringName):
	if anim_name == "slide_in":
		get_tree().change_scene_to_file("res://menu/credit_screen.tscn")

func _on_timer_timeout():
	can_select = true
	$TextPlayer.play("default")

