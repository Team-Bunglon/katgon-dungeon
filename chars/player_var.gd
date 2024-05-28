extends Node
class_name PlayerGlobal

# Debug 
@onready var debug: bool = true

# Global variable
@onready var leader_position: Vector2
@onready var partner_position: Vector2
@onready var cherry: int = 0
@onready var cherry_all: int = 8

# Win variables
@onready var game_run: bool = false
@onready var final_time: String
@onready var game_complete: bool = false

# Pause menu node
@onready var is_paused: bool = false
@onready var is_pausing: bool = false
@onready var pause_menu: Control

func load_stuff():
	pause_menu = get_tree().get_root().find_child("PauseMenu", true, false)
	cherry = 0
	game_run = true
	is_paused = false
	is_pausing = false

func switch_position() -> void:
	var temp_position = leader_position
	leader_position = partner_position
	partner_position = temp_position

func get_distance() -> float:
	return leader_position.distance_to(partner_position)

func get_final_time():
	final_time = pause_menu.get_current_time()

