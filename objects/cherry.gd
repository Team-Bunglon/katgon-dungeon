extends Area2D

@onready var state = $AnimationTree.get("parameters/playback")
@onready var obtain_node: ObtainUI = get_tree().get_root().find_child("ObtainUI", true, false)

func _on_body_entered(body:Node2D):
	if "Player" in body.name:
		PlayerVar.cherry += 1
		Sound.play("Obtain")
		state.travel("obtain")
		obtain_node.show_obtain()
		disconnect("body_entered", _on_body_entered)
