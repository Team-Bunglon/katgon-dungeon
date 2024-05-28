# It's kinda funny that the flameball is considered as a "character"
# Blame it on Godot for removing KinematicBody2D
extends CharacterBody2D
class_name Flameball

# You can only change export variable here. Oops
@export var speed:int = 800
@export var body_hit: Array[String] 
@export var body_pass: Array[String] = ["Player1", "Player2", "VoidMap"]

@onready var direction: Vector2
@onready var is_moving: bool = true

# Animation Stuff
@onready var state: Variant = $AnimationTree.get("parameters/playback")

func _physics_process(_delta):
	if is_moving:
		travel()
	if velocity == Vector2.ZERO and is_moving: # A workaround when the flameball doesn't detect collision but still stopped regardless
		hit()

## Shoot the flameball out of Gon's mouth.
func shoot(position_spawn: Vector2, direction_spawn: Vector2):
	position = set_position_spawn(position_spawn, direction_spawn)
	direction = direction_spawn

func travel():
	velocity = speed * direction
	move_and_slide()

func hit():
	is_moving = false
	velocity = Vector2.ZERO
	state.travel("hit")
	Sound.play("FlameballHit")

func set_position_spawn(pos: Vector2, dir: Vector2) -> Vector2:
	if dir.y > 0: # South
		return Vector2(pos.x, pos.y + 35)
	elif dir.y < 0: # North
		return Vector2(pos.x, pos.y - 50)
	elif dir.x < 0: # West
		return Vector2(pos.x - 25, pos.y + 30)
	elif dir.x > 0: # East
		return Vector2(pos.x + 25, pos.y + 30)
	else:
		return pos

func _on_flame_area_2d_body_entered(body:Node2D):
	var body_name: String
	if "#" in body.name:
		body_name = body.name.get_slice("#",0)
	else:
		body_name = body.name
	if not body_name in body_pass:
		if is_moving: hit()
		if body_name in body_hit:
			body.hit()

func _on_animation_tree_animation_finished(anim_name:StringName):
	if anim_name == "hit":
		queue_free()
