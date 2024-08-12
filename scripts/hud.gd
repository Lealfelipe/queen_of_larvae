extends CanvasLayer

const PRE_HUD_HEART = preload("res://scenes/hud_hearth.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in Game.heart:
		var heart = PRE_HUD_HEART.instantiate()
		$hbox.add_child(heart)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	show_hearts()
	
func show_hearts():
	for i in $hbox.get_child_count():
		$hbox.get_child(i).visible = Game.heart > i
