extends Area2D

const PRE_HEARTH = preload("res://scenes/particles_redtscn.tscn")
const PRE_HUD_HEART = preload("res://scenes/hud_hearth.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if Game.heart == Game.maxHeart:
		Game.addHeart()
		Game.maxHeart += 1
		$"../../hud/hbox".add_child(PRE_HUD_HEART.instantiate())
	else:
		Game.addHeart()
		
	_particles()
	queue_free()


func _particles():
	var h = PRE_HEARTH.instantiate()
	h.position = position
	get_parent().add_child(h)
