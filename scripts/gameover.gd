extends ColorRect

var reiniciar = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$anim.play('fadein') # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	if event is InputEvent and reiniciar and !event is InputEventMouseMotion:
		if event.pressed:
			Game.resetGame()
			get_tree().change_scene_to_file("res://scenes/fase1.tscn")
		


func _on_anim_animation_finished(anim_name):
	reiniciar = true
