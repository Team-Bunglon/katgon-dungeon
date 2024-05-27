extends Area2D

@onready var state = $AnimationTree.get("parameters/playback")
@onready var is_obtained: bool = false
@onready var obtain_node: Control = get_tree().get_root().find_child("ObtainUI", true, false)

func _on_body_entered(body:Node2D):
	if "Player" in body.name and not is_obtained:
		PlayerVar.cherry += 1
		state.travel("obtain")
		is_obtained = true

		# This variables are kinda useless
		$CollisionShape2D.disabled = true
		monitoring = false
		monitorable = false

		obtain_node.get_node("ObtainLabel").text = "Golden Cherry obtained!"
		obtain_node.visible = true
		await get_tree().create_timer(3).timeout
		obtain_node.visible = false
