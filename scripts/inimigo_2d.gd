extends CharacterBody2D

const PRE_EXPLOSION = preload("res://scenes/explosion.tscn")
const GRAVITY = 1000
var speed = 150
var valor_alpha = 0

@export_enum('left', 'right') var dir = 0
@export var speed_value = 0.1

# Called when the node enters the scene tree for the first time.
func _ready():
	if dir == 0: #left"res://scenes/explosion.tscn"
		scale.x = 1
	else:
		scale.x = -1
	$anim.animation_finished.connect(finish)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.y += GRAVITY * delta
	
	if $ray.is_colliding():
		if dir == 0:
			speed = -150
		else:
			speed = 150
	else:
		scale.x *= -1 #mudanca de direcão
		if dir == 0:
			dir = 1
		else:
			dir = 0
			
	velocity.x = speed * speed_value
	
	move_and_slide()
	flash(0.05)


func _on_corpo_2d_body_entered(body):
	if Game.heart > 0:
		if body.position.x < position.x:
			body.hitted(-400)
		if body.position.x > position.x:
			body.hitted(400)
			


func _on_corpo_2d_area_entered(area):
	if Game.heart > 0 and !area.get_parent().hit:
		area.get_parent().jump()
		$anim.play("die")
		explosion()
		valor_alpha = 1
		
	

func finish(anim_name):
	match anim_name:
		'die':
#			explosion()
			queue_free()
			

func explosion():
	var explosion = PRE_EXPLOSION.instantiate()
	explosion.global_position = global_position + Vector2(0,20)
	get_parent().add_child(explosion)


func flash(valor):
	$sprite2d.material.set_shader_parameter('alpha', valor_alpha)
	if valor_alpha > 0:
		valor_alpha -= valor








