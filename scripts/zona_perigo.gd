extends Area2D

var nave = null
var calor_normal := 0.0
var calor_mortal := 1.0
var dist_mortal := 847.0
@onready var dist_normal = $CollisionShape2D.shape.radius
@onready var filtro = $"../FiltroCalor/Cor"

var dano_maximo := 500.0


func _process(delta: float) -> void:
	if nave != null:
		var dist_nave_sol = global_position.distance_to(nave.global_position)
		var formula_calor = (dist_nave_sol - dist_mortal)/(dist_normal - dist_mortal) * (calor_normal - calor_mortal) + calor_mortal
		var calor_atual = clamp(formula_calor, calor_normal, calor_mortal)
		filtro.color.a = calor_atual
		var dano_atual = ((dano_maximo*calor_atual)/calor_mortal) * delta
		nave.receber_dano(dano_atual)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("jogador"):
		print("Nave entrou na zona de perigo")
		nave = body

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("jogador"):
		print("Nave saiu da zona de perigo")
		nave = null
