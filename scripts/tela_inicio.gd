extends Control


func _on_botao_jogar_pressed():
	Audio.tocar_clique()
	get_tree().change_scene_to_file("res://cenas/tela_jogo.tscn")

func _on_botao_sair_pressed():
	get_tree().quit()
