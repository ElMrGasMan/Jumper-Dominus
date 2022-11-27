extends Control


export(String, FILE, "*.tscn") var pantalla_carga = ""


func _ready():
	DataDelJugador.resetear()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_ButtonMenuPrincipal_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://juego/Menus/MenuPrincipal.tscn")


func _on_ButtonContinuar_pressed():
	DataDelJugador.cargando_partida = true
# warning-ignore:return_value_discarded
	get_tree().change_scene(pantalla_carga)


func _on_ButtonSalir_pressed() -> void:
	get_tree().quit()
