class_name MusicaJuego
extends Node


export(float, -30.0, -10.0, 5.0) var volumen_apagado = -40.0

var musica_actual_apagar: float = 0.0

onready var musica_ambiental: AudioStreamPlayer = $MusicaAmbiental setget, get_mus_amb
onready var musica_menu: AudioStreamPlayer = $MusicaMenu setget, get_musica_menu


# warning-ignore:unused_argument
func _on_TweenApagarMusica_tween_completed(object: Object, key: NodePath) -> void:
	object.stop()
	object.volume_db = musica_actual_apagar


func get_musica_menu() -> AudioStreamPlayer:
	return musica_menu


func get_mus_amb() -> AudioStreamPlayer:
	return musica_ambiental


func detener_musica() -> void:
	for node in get_children():
		if node is AudioStreamPlayer:
			node.stop()


func ejecutar_musica(musica: AudioStreamPlayer) -> void:
	if not musica.playing:
		detener_musica()
		musica.play()
