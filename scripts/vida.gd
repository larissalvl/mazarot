extends CanvasLayer

@onready var barra_vida = $barraVida
@onready var nave = get_tree().get_first_node_in_group("nave")
@onready var fill = barra_vida.get_theme_stylebox("fill")

func _ready():
	atualizar_vida()
	nave.vida_mudou.connect(atualizar_vida)

func atualizar_vida():
	barra_vida.max_value = nave.vida_maxima
	barra_vida.value = nave.vida_atual
	if barra_vida.value <= 0.25 * barra_vida.max_value:
		fill.bg_color = Color("#ff0000ff")
	elif barra_vida.value <= 0.55 * barra_vida.max_value:
		fill.bg_color = Color("#fdea00")
	else:
		fill.bg_color = Color("#75e9fb")
