extends Control
class_name PauseMenu

@export var confirm_quit_text: String = "Quit game?"
@export var confirm_restart_text: String = "Restart game?"

func toggle_pause():
	if not PlayerVar.is_pausing:
		PlayerVar.is_pausing = true
		if PlayerVar.is_paused: # Resuming
			Engine.time_scale = 1
			$PauseOptions.exit_focus()
			$AnimationPlayer.play("slide_out")
		else: # Pausing
			PlayerVar.is_paused = true
			$PauseOptions.visible = true
			$PauseOptions.get_focus()
			$CherryLabel.text = str(PlayerVar.cherry)
			$TimeLabel.text = get_current_time()
			$Map.generate_map()
			hide_confirm()
			$AnimationPlayer.play("slide_in")

func get_current_time():
	return str($Stopwatch.get_elapsed_time_as_formatted_string("{MM}:{ss}"))

func show_confirm_quit():
	$ConfirmLabel.text = confirm_quit_text
	$ConfirmLabel.visible = true

func show_confirm_restart():
	$ConfirmLabel.text = confirm_restart_text
	$ConfirmLabel.visible = true

func hide_confirm():
	$ConfirmLabel.visible = false

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "slide_in":
		Engine.time_scale = 0
	elif anim_name == "slide_out":
		$PauseOptions.visible = false
		PlayerVar.is_paused = false
	PlayerVar.is_pausing = false

func _on_player_1_pause_signal():
	toggle_pause()

