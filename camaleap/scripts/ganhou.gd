extends Control

@onready var music = $AudioStreamPlayer2D

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/jogo.tscn")

func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _on_button_3_pressed() -> void:
	get_tree().quit()

func _on_audio_stream_player_2d_finished() -> void:
	music.play()
