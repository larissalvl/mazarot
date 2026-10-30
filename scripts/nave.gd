extends CharacterBody2D

#velocidade de nave
var vel_nave_base = 350
var vel_nave_atual = vel_nave_base
var vel_angular_base = PI/2
var vel_angular_atual = vel_angular_base

#vida da nave
var vida_maxima := 1000.0
var vida_atual := vida_maxima
var vivo := true
signal vida_mudou

#separa nave do propulsor
@onready var spriteFogo = $SpriteFogo
@onready var spriteNave = $SpriteNave

#guarda animações em variáveis
var spriteFogoNormal = "FogoNormal"
var spriteFogoRapido = "FogoRapido"
var spriteNaveArmada = "NaveArmada"

#nave com animação do fogo para a velocidade normal
var spriteFogoAtual = spriteFogoNormal

#nave inicia não armada
var naveArmada := false

#cria a variável global de movimento nave
var movNave

#função que roda 1 vez quando o jogo inicia
func _ready():
	spriteFogo.play(spriteFogoAtual)

#função que roda a cada frame
func _process(delta):
	if Input.is_action_pressed("Acelerar"):
		vel_nave_atual = 700
		vel_angular_atual = vel_angular_base * 2
		spriteFogoAtual = spriteFogoRapido
	else:
		vel_nave_atual = vel_nave_base
		vel_angular_atual = vel_angular_base
		spriteFogoAtual = spriteFogoNormal
	if Input.is_action_pressed("paraEsquerda"):
		rotation -= vel_angular_atual * delta
	if Input.is_action_pressed("paraDireita"):
		rotation += vel_angular_atual * delta
	if Input.is_action_pressed("paraTras"):
		movNave = Vector2.DOWN.rotated(rotation) * vel_nave_atual
		position += movNave * delta
	if Input.is_action_pressed("paraFrente") or Input.is_action_pressed("Acelerar"):
		movNave = Vector2.UP.rotated(rotation) * vel_nave_atual
		position += movNave * delta
	if Input.is_action_just_pressed("Armar"):
		armar()
	spriteFogo.play(spriteFogoAtual)

#função que diz como animação deve rodar
func armar():
	if not naveArmada:
		spriteNave.play(spriteNaveArmada)
		naveArmada = true
	else:
		spriteNave.play_backwards(spriteNaveArmada)
		naveArmada = false

#função que diminui a vida
func receber_dano(dano):
	if not vivo:
		return
	vida_atual -= dano
	vida_atual = max(vida_atual, 0)
	vida_mudou.emit()
	if vida_atual <= 0:
		morrer()
		vivo = false

#função que recarrega a cena quando a nave morre
func morrer():
	print("A nave morreu")
	get_tree().reload_current_scene()
