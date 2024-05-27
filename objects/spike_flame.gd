extends SpikeTile

func _ready():
	raise_layer = collision_layer
	retract_layer = 8
	super._ready()
