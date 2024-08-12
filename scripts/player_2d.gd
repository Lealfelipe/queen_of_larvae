extends CharacterBody2D


const SPEED = 300.0
const JUMP_FORCE = -500.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var GRAVITY = 1000
var was_falling = false

#jump
var is_jump = false

#hit
var hit = false



#gameover
var gameover = false

#interação com a caixa
var contact_object = false
var move_object = false




#função para movimentação
func _process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	var direction = Input.get_axis("ui_left", "ui_right")
	
	#emissao da poeira
	if is_on_floor() and direction and !move_object:
		$smoke.emitting = true
	else:
		$smoke.emitting = false
	
	if Game.heart > 0 and !move_object:
		if !is_jump and !hit:
			if was_falling:
				$anim.play("landing")
			else:	
				if direction:
					$anim.play('running')
				else:
					$anim.play('idle')
			if !is_on_floor():
				$anim.play("jump2")
				was_falling = false
		else:
			was_falling = false
					
					
		if direction and !hit:
			$sprite2d.scale.x = direction * -1 #espelhar movimento (direita/esquerda)
			velocity.x = move_toward(velocity.x, direction * SPEED, SPEED*0.2) #controle de velocidade do movimento (SPEED (vel. Movi), SPEED*0.5 (vel. Inicio mov.))
				
		else:
			if is_on_floor():
				velocity.x = move_toward(velocity.x, 0, SPEED*0.05) #func para personagem conclui o movimento de SPEED suavemente quando solta o botão (Deslizar ao soltar o botão)
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED*0.005) #func para personagem conclui o movimento de JUMP suavemente quando solta o botão
			
	
		if is_on_floor():
			is_jump = false

		
		# Handle Jump.
		if Input.is_action_just_pressed("ui_accept") and !is_jump and !hit:
			jump()

		move_and_slide()
	
	else:
		if Game.heart > 0:
			if direction:
				velocity.x = move_toward(velocity.x, direction * SPEED / 5, SPEED*0.2)
			else:
				velocity.x = 0
			move_and_slide()
		else:
			velocity.x = 0
			if !is_on_floor():
				move_and_slide()
		
	if Input.is_action_just_pressed("move_object") and contact_object:
		if !move_object:
			move_object = true
		else:
			move_object = false
		print('Mover Objeto')
	
#funcao de pulo1 e pulo2
func jump():
	$anim.play('jump')
	is_jump = true
	velocity.y = JUMP_FORCE
	
func jump2():
	$anim.play("jump2")
	

func is_falling():
	was_falling = true



func _on_anim_animation_finished(_anim_name):
	print("Animation finished: " + str(_anim_name))  # Debugging output
	match _anim_name:
		'jump':
			print("Calling jump2()")  # Debugging output
			jump2()
		'landing':
			is_falling()
		'hit':
			hit = false
		'die':
			get_tree().change_scene_to_file("res://scenes/gameover.tscn")
		
#função para hit que personagem sofre e morte
func hitted(force):
	move_object = false
	Game.removeHeart()
	if Game.heart > 0:
		$anim.play('hit')
	else:
		$anim.play("die")
	hit = true
	velocity.x = force
	velocity.y = -200


	
		
		
		
