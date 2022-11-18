class_name MenuIntermedio
extends Control


onready var titulo_nivel: Label = $Label
onready var titulo_puntaje: Label = $Label2


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	titulo_nivel.text = "¡Nivel {num} Completado!".format({"num": DataDelJugador.num_nivel_actual})
	titulo_puntaje.text = "Puntaje Actual: \n {punt}".format({"punt": DataDelJugador.obtener_puntaje()})



func _on_BotonNivelSiguiente_pressed() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene(DataDelJugador.nivel_siguiente)
