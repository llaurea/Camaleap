extends Node2D

@onready var music = $"../AudioStreamPlayer2D"

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().paused = not get_tree().paused

func _on_audio_stream_player_2d_finished() -> void:
	music.play()
