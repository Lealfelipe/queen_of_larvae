extends Area2D

const PRE_CRISTAL = preload("res://scenes/particlesgreen.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	_particles()
	queue_free()
	get_tree().change_scene_to_file("res://scenes/endgame.tscn")


func _particles():
	var c = PRE_CRISTAL.instantiate()
	c.position = position
	get_parent().add_child(c)
