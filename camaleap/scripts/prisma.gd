extends CharacterBody2D

#Configurações da movimentação
@export var move_speed: float = 250.0 #Horizontal
@export var jump_force: float = 450.0 #Pulo
@export var gravity: float = 1000.0 #Gravidade

#Estados que começa
var direction: int = 1 #Começa para a direita
var jumps_left: int = 2 #Tem dois pulos
var on_wall: bool = false #Ele não começa encostado na parede

func _physics_process(delta): #Aplica gravidade
	velocity.y += gravity * delta

	#Se estiver encostado em uma parede e fora do chão, o personagem desliza para baixo ao invés de só trocar o lado
	if on_wall and not is_on_floor():
		velocity.x = 0
		velocity.y = min(velocity.y, 200)  #Escorrega para baixo
	else:
		velocity.x = direction * move_speed

	move_and_slide() #Pra realmente se movimentar e colidir

	#Para ver se está no chão
	if is_on_floor():
		jumps_left = 2
		on_wall = false

	#Para ver se está colidindo com alguma parede
	on_wall = false
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_normal().x != 0:
			if is_on_floor():
				#No chão encostando em uma parede → muda a direção
				direction *= -1
			else:
				#No ar encostando na parede → desliza pela própria parede
				on_wall = true
			jumps_left = 2  #Os pulos resetam
			break

	#Para pular
	if Input.is_action_just_pressed("ui_accept"):
		if jumps_left > 0:
			velocity.y = -jump_force
			jumps_left -= 1
			if on_wall:
				direction *= -1
				on_wall = false

	#Para flipar o sprite depois (se realmentar for fazer assim) só tirar a # que está embaixo
	$Sprite2D.flip_h = direction < 0

func _on_morte_body_entered(body: Node2D) -> void:
	if body == self:
		die()

func die():
	# reseta
	get_tree().reload_current_scene()
