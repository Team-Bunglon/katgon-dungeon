extends Control
@onready var transition := get_tree().get_root().find_child("Transition", true, false)

func _on_menu_do_item(item:Control):
	if not PlayerVar.is_paused or PlayerVar.is_pausing:
		return
	else:
		if item.name == "No":
			visible = false
			$"../../PauseOptions".visible = true
			$"../../PauseOptions".get_focus()
		elif item.name == "Yes":
			transition.play("slide_in_quit")

func get_focus():
	$Menu/No.grab_focus()

func quit_focus():
	$Menu/No.release_focus()
	$Menu/Yes.release_focus()
