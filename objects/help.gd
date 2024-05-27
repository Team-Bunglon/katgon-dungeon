extends Area2D

@export var help_text_top: String = "Sample Text"
@export var help_text_bottom: String = "Bottom Text"
@onready var help_node: Control = get_tree().get_root().find_child("HelpUI", true, false)
@onready var obtain_node: Control = get_tree().get_root().find_child("ObtainUI", true, false)
@onready var state: Variant = $AnimationTree.get("parameters/playback")

func _on_body_entered(body:Node2D):
	if "Player" in body.name:
		obtain_node.hide()
		help_node.get_node("HelpLabelTop").text = help_text_top
		help_node.get_node("HelpLabelBottom").text = help_text_bottom
		help_node.show()
		state.travel("step")
		
func _on_body_exited(body:Node2D):
	if "Player" in body.name:
		help_node.hide()
		state.travel("idle")

