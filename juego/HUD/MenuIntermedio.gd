class_name MenuIntermedio
extends Control


export(String, FILE, "*.tscn") var pantalla_carga = ""

onready var titulo_nivel: Label = $Label
onready var titulo_puntaje: Label = $Label2
onready var boton_nivel_siguiente: Button = $BotonNivelSiguiente


func _ready() -> void:
	MusicaStellarRaiders.ejecutar_musica(MusicaStellarRaiders.get_musica_menu())
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if DataDelJugador.num_nivel_actual == 3:
		titulo_nivel.text = "¡Nivel Final Completado! \n ¡Felicidades!"
		boton_nivel_siguiente.text = "Menú Principal"
	else:
		titulo_nivel.text = "¡Nivel {num} Completado!".format({"num": DataDelJugador.num_nivel_actual})
	
	titulo_puntaje.text = "Puntaje Conseguido: \n {punt} \n Tu puntaje total es: \n {punt_tot}".format({"punt": DataDelJugador.obtener_puntaje(), "punt_tot": DataDelJugador.puntaje_total})


func _on_BotonNivelSiguiente_pressed() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene(pantalla_carga)
