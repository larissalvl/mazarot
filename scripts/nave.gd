extends CharacterBody2D

var vel_nave_base = 350
var vel_nave_atual = vel_nave_base
var vel_angular_base = PI/2
var vel_angular_atual = vel_angular_base

var vida_maxima := 1000.0
var vida_atual := vida_maxima
var vivo := true
signal vida_mudou

func _ready():
	var sprite = $AnimatedSprite2D
	sprite.play("nave")
	

func _process(delta):
	if Input.is_action_pressed("paraEsquerda"):
		rotation -= vel_angular_atual * delta
	if Input.is_action_pressed("paraDireita"):
		rotation += vel_angular_atual * delta
	if Input.is_action_pressed("paraTras"):
		var movNave = Vector2.DOWN.rotated(rotation) * vel_nave_atual
		position += movNave * delta
	if Input.is_action_pressed("paraFrente"):
		var movNave = Vector2.UP.rotated(rotation) * vel_nave_atual
		position += movNave * delta
	if Input.is_action_pressed("Acelerar"):
		vel_nave_atual = 700
		vel_angular_atual = vel_angular_base * 2
	else:
		vel_nave_atual = vel_nave_base
		vel_angular_atual = vel_angular_base
		
func receber_dano(dano):
	if not vivo:
		return
	vida_atual -= dano
	vida_atual = max(vida_atual, 0)
	vida_mudou.emit()
	if vida_atual <= 0:
		morrer()
		vivo = false
	
func morrer():
	print("A nave morreu")
