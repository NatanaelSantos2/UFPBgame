extends CharacterBody2D

@export_category("Movimentação")
@export var speed: float = 100.0
@export var joystick: TouchScreenButton # precisa ter método get_joystick_dir()
var threshold = 0.4 # valor mínimo para considerar eixo dominante
@onready var player: CharacterBody2D = $"."

# Referência para o AnimatedSprite2D (ou AnimationPlayer, se usar esse)
@onready var anim: AnimatedSprite2D = $Animated


func _physics_process(_delta: float) -> void:
	velocity = Vector2.ZERO

	# Direção do joystick (ou teclado se quiser misturar)
	var input_dir: Vector2 = joystick.get_joystick_dir().normalized()

	if input_dir != Vector2.ZERO:
		velocity = input_dir * speed

	move_and_slide()

	# ----------- ANIMAÇÕES -----------
	if input_dir == Vector2.ZERO:
		anim.play("idle_down")
	else:
		if abs(input_dir.x) > threshold and abs(input_dir.y) > threshold:
			if input_dir.x > 0 and input_dir.y < 0:
				anim.play("new_animation") # cima-direita
			elif input_dir.x < 0 and input_dir.y < 0:
				anim.play("new_animation_1") # cima-esquerda
			elif input_dir.x > 0 and input_dir.y > 0:
				anim.play("new_animation_2") # baixo-direita
			elif input_dir.x < 0 and input_dir.y > 0:
				anim.play("new_animation_3") # baixo-esquerda
		elif abs(input_dir.x) > abs(input_dir.y):
			if input_dir.x > 0:
				anim.play("walk_right")
			else:
				anim.play("walk_left")
		else:
			if input_dir.y > 0:
				anim.play("walk_down")
			else:
				anim.play("walk_up")
