extends CanvasLayer

@onready var label_titulo := %LabelTitulo
@onready var mensagem := %Mensagem
@onready var botao := %Botao

func estabelecer_titulo(titulo: String):
	label_titulo.text = titulo
	
func estabelecer_msg(msg: String):
	mensagem.text = msg

func estabelecer_texto_botao(btn: String):
	botao.text = btn

func _ready() -> void:
	get_tree().set_pause(true)
	botao.pressed.connect(_on_botao_pressed)

func _on_botao_pressed() -> void:
	get_tree().set_pause(false)
	queue_free()
