extends Node2D

@onready var win_scene = "res://menu/win_screen.tscn"
@onready var transition_node: AnimationPlayer = $"../CanvasLayer/Transition"
@onready var state = $AnimationTree.get("parameters/playback")
@onready var is_obtained: bool = false
@onready var player_in_area: Array[String]
@onready var can_win: bool = false 

signal on_collected(collect_status: bool)

func you_win():
	on_collected.emit(true)
	$WinSound.play()
	state.travel("obtain")
	is_obtained = true
	PlayerVar.get_final_time()
	PlayerVar.game_run = false
	PlayerVar.game_complete = true
	Music.stop()
	var tween := create_tween()
	tween.tween_property(self, "position", position + Vector2(0,-180), 1)
	await get_tree().create_timer(2).timeout
	transition_node.play("slide_in")

func _on_player_area_body_exited(body:Node2D):
	if "Player" in body.name:
		player_in_area.erase(body.name)
		can_win = false

func _on_player_area_body_entered(body:Node2D):
	if "Player" in body.name:
		player_in_area.append(body.name)
		if len(player_in_area) == 2:
			can_win = true

func _on_fruit_area_body_entered(body:Node2D):
	if "Player" in body.name:
		if can_win and not is_obtained:
			you_win()
		elif not can_win:
			on_collected.emit(false)
		elif is_obtained:
			return

func _on_transition_animation_finished(anim_name):
	if anim_name == "slide_in":
		get_tree().change_scene_to_file(win_scene)
