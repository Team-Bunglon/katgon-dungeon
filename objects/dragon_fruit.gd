extends Node2D

@onready var transition_node: AnimationPlayer = get_tree().get_root().find_child("Transition", true, false)
@onready var state = $AnimationTree.get("parameters/playback")
@onready var player_in_area: Dictionary
@onready var is_obtained: bool = false
@onready var can_win: bool = false 

signal on_collected(collect_status: bool)

func you_win():
	Sound.play("Win")
	Music.pause()

	on_collected.emit(true)
	state.travel("obtain")
	is_obtained = true

	PlayerVar.get_final_time()
	PlayerVar.game_run = false
	PlayerVar.game_complete = true

	# TODO: Add camera shake and screen flash effect here!

	# I could use Animation Player but this is fine as it is.
	var tween := create_tween()
	tween.tween_property(self, "position", position + Vector2(0,-180), 1)
	await get_tree().create_timer(2).timeout
	transition_node.play("slide_in")

func _on_player_area_body_exited(body:Node2D):
	if "Player" in body.name:
		player_in_area.erase(body.name)
		can_win = false
		print(player_in_area)

func _on_player_area_body_entered(body:Node2D):
	if "Player" in body.name:
		player_in_area[body.name] = true
		if len(player_in_area) >= 2:
			can_win = true
		print(player_in_area)

func _on_fruit_area_body_entered(body:Node2D):
	if "Player" in body.name:
		if can_win and not is_obtained:
			you_win()
		elif not can_win:
			on_collected.emit(false)
		elif is_obtained:
			return
