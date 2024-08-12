extends CharacterBody2D

const GRAVITY = 1000
@onready var player = $'../player2d'
const SPEED = 300
var move = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
#	$area_contato.body_entered.connect('on_area_contato_body_entered') #criando conexões via script
#	$area_contato.body_exited.connect('on_area_contato_body_exited')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.y += GRAVITY * delta
	velocity.x = 0
	
	var direction = Input.get_axis('ui_left', 'ui_right')
	if player.move_object and $ray.is_colliding() and $ray.is_in_group('move') and !player.is_jump:
		velocity.x = move_toward(velocity.x, direction * SPEED / 5, SPEED*0.2)
		if player.position.x > position.x:
			if direction == -1:
				player.get_node("anim").play('empurrar')
			elif direction == 1:
				player.get_node("anim").play('puxar')
			else:
				if !move:
					player.get_node('anim').play('move_object')
					move = true
		else:
			if direction == -1:
				player.get_node("anim").play('puxar')
			elif direction == 1:
				player.get_node("anim").play('empurrar')
			else:
				if !move:
					player.get_node('anim').play('move_object')
					move = true
					
		if player.position.y - position.y > 20 or player.position.y - position.y < -20:
			player.move_object = false
	else:
		move = false
					
	if direction:
		move = false
		
	if player.contact_object:
		if player.is_jump:
			player.move_object = false
	
	if $ray.is_in_group('move'):
		if player.position.y - position.y < -20:
			player.contact_object = false
		else:
			player.contact_object = true		
		
	move_and_slide()


func _on_area_contato_body_entered(body):
	if body.name == "player2d":
		if (get_tree().get_nodes_in_group('move').size()) < 1: 
			$ray.add_to_group('move')
			
		if player.position.y - position.y < -20:
			body.contact_object = false
		else:
			body.contact_object = true			 
		body.contact_object = true
		print('Press X')
		
		if player.position.x > position.x:
			$ray.target_position.x = 75
		else:
			$ray.target_position.x = -75


func _on_area_contato_body_exited(body):
	if body.name == "player2d":
		if $ray.is_in_group('move'):
			$ray.remove_from_group('move')
			body.contact_object = false
			body.move_object = false
