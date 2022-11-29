tool
extends Control


export(String, FILE, "*.tscn") var menu_opciones = ""
export(String, FILE, "*.tscn") var nivel_inicial = ""
export(String, FILE, "*.tscn") var pantalla_carga = ""

onready var sfx_seleccion: AudioStreamPlayer = $AudioStreamPlayer
onready var boton_cargar: Button = $VBoxContainer/ButtonCargar


func _ready() -> void:
	MusicaStellarRaiders.ejecutar_musica(MusicaStellarRaiders.get_musica_menu())
	var existencia_ruta: GuardarCargar = GuardarCargar.new()
	
	if existencia_ruta.chequear_existencia_datos_guardados() == false:
		boton_cargar.disabled = true
	
	else:
		boton_cargar.disabled = false


func _on_ButtonSalir_pressed() -> void:
	get_tree().quit()


func _on_ButtonOpciones_pressed() -> void:
	sfx_seleccion.play()
# warning-ignore:return_value_discarded
	get_tree().change_scene(menu_opciones)


func _on_ButtonNueva_pressed() -> void:
	sfx_seleccion.play()
# warning-ignore:return_value_discarded
	DataDelJugador.nivel_siguiente = nivel_inicial
	get_tree().change_scene(pantalla_carga)


func _on_ButtonCargar_pressed() -> void:
	var datos_guardados: GuardarCargar = GuardarCargar.new()
# warning-ignore:return_value_discarded
	datos_guardados.cargar_datos_partida()
# warning-ignore:return_value_discarded
	DataDelJugador.cargando_partida = true
	get_tree().change_scene(pantalla_carga)


func _get_configuration_warning() -> String:
	if menu_opciones == "" or nivel_inicial == "" or pantalla_carga == "":
		return "Algun export no esta cargado"
	
	return ""
