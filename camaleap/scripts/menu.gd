extends Control

#Quando apertar o botão "Start", muda a cena para a cena do jogo
func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/jogo.tscn")

#Quando apertar o botão "Quit", o jogo fecha.
func _on_quit_pressed() -> void:
	get_tree().quit()

#Quando apertar mute é pra parar a música de fundo (não temos música então nn mexi nele)
func _on_mute_pressed() -> void:
	print ("calaboca")
