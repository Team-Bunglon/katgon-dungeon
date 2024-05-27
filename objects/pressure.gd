extends Area2D

## A tile that can give signal to other tile when stepped on (SpikeTile at the moment)
## The name MUST include #num at the end and it has to be unique for the whole project.
class_name PressureTile

@export var target_name: Array[String]

@onready var target_node: Array[Node]
@onready var number = get_number()
@onready var body_inside: Dictionary
	
func _ready():
	for n in target_name:
		target_node.append(get_tree().get_root().find_child(n, true, false))
	RoomVar.button_states[number] = false

func _on_body_entered(body:Node2D):
	if "Player" in body.name:
		body_inside[body.name] = true
		$Sprite2D.frame = 1
		RoomVar.button_states[number] = true
		for n in target_node:
			n.detect_button_presses()

func _on_body_exited(body:Node2D):
	if "Player" in body.name:
		body_inside.erase(body.name)
		if body_inside.is_empty():
			$Sprite2D.frame = 0
			RoomVar.button_states[number] = false
			for n in target_node:
				n.detect_button_presses()

func get_number():
	if "#" in name:
		return int(name.get_slice("#",1))
	else:
		assert(false, "You forgot to put #int after a button name.")


