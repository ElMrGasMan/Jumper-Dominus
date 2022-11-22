class_name MenuOpciones
tool
extends Control


export(String, FILE, "*.tscn") var menu_inicio = ""

onready var boton_pantalla_completa: CheckBox = $Panel/HBoxContainer2/ContenedorPantalla/PantallaCompleta
onready var boton_resoluciones = $Panel/HBoxContainer2/ContenedorPantalla/Resolucion/OptionButton
onready var resoluciones:= {
	"640 x 480": Vector2(640, 480),
	"960 x 640": Vector2(960, 640),
	"1240 x 720": Vector2(1240, 720),
	"1600 x 900": Vector2(1600, 900),
	"1920 x 1080": Vector2(1920, 1080)
}
onready var indices_bus_audio:= {
	"Master": AudioServer.get_bus_index("Master"),
	"SFX": AudioServer.get_bus_index("SFX"),
	"Musica": AudioServer.get_bus_index("Musica")
}
onready var etiquetas_bus_audio:= {
	"Master": $Panel/HBoxContainer2/ContenedorVolumen/VolumenGeneral/VolumenCant,
	"Musica":$Panel/HBoxContainer2/ContenedorVolumen/VolumenMusica/VolumenCant,
	"SFX": $Panel/HBoxContainer2/ContenedorVolumen/VolumenSFX/VolumenCant
}


func _ready() -> void:
	boton_pantalla_completa.set_pressed(OS.window_fullscreen)
	poner_resoluciones()
	poner_volumen_buses()
	resolucion_actual()


func _on_BotonRegresar_pressed() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene(menu_inicio)
	


func _on_PantallaCompleta_toggled(button_pressed: bool) -> void:
	OS.window_fullscreen = button_pressed


func _on_OptionButton_item_selected(index: int) -> void:
	var resolucion_nueva: Vector2 = resoluciones[boton_resoluciones.get_item_text(index)]
	OS.window_size = resolucion_nueva
	centralizar_pantalla(OS.window_size)


func _on_BotonAumentarGeneral_pressed() -> void:
	cambiar_volumen(indices_bus_audio.Master, true)


func _on_BotonDisminuirGeneral_pressed() -> void:
	cambiar_volumen(indices_bus_audio.Master, false)


func _on_BotonAumentarMusica_pressed() -> void:
	cambiar_volumen(indices_bus_audio.Musica, true)


func _on_BotonDisminuirMusica_pressed() -> void:
	cambiar_volumen(indices_bus_audio.Musica, false)


func _on_BotonAumentarSFX_pressed() -> void:
	cambiar_volumen(indices_bus_audio.SFX, true)


func _on_BotonDisminuirSFX_pressed() -> void:
	cambiar_volumen(indices_bus_audio.SFX, false)


func poner_resoluciones() -> void:
	for res in resoluciones.keys():
		boton_resoluciones.add_item(res)


func centralizar_pantalla(res: Vector2) -> void:
	var tamanio_pant := OS.get_screen_size()
	OS.set_window_position(tamanio_pant * 0.5 - res * 0.5)


func resolucion_actual() -> void:
	var string_resolucion_actual = String(OS.window_size.x) + " x " + String(OS.window_size.y)
# warning-ignore:unused_variable
	var indice_res_selecc: int = 0
	
	for i in range(boton_resoluciones.get_item_count()):
		
		if string_resolucion_actual == boton_resoluciones.get_item_text(i):
			boton_resoluciones.select(i)
			indice_res_selecc = i


func poner_volumen_buses() -> void:
	
	for bus in indices_bus_audio.values():
		var volumen_actual: float = AudioServer.get_bus_volume_db(bus)
		var nombre_bus: String = AudioServer.get_bus_name(bus)
		var numero_volumen: String = "%01d" % (volumen_actual + 50)
		etiquetas_bus_audio[nombre_bus].text = numero_volumen
		
		if nombre_bus == "Master" and volumen_actual <= -50:
			mutear_buses(true)
		
		elif nombre_bus == "Master" and volumen_actual > -50:
			mutear_buses(false)


func cambiar_volumen(index_bus: int, subir_vol: bool) -> void:
	var volumen_ant: float = AudioServer.get_bus_volume_db(index_bus) 
	var volumen_nuev: float
	
	if subir_vol:
		volumen_nuev = volumen_ant + 1
	
	else:
		volumen_nuev = volumen_ant - 1
	
	volumen_nuev = clamp(volumen_nuev, -50, 150)
	AudioServer.set_bus_volume_db(index_bus, volumen_nuev)
	poner_volumen_buses()


func mutear_buses(muteado: bool) -> void:
	AudioServer.set_bus_mute(indices_bus_audio.Musica, muteado)
	AudioServer.set_bus_mute(indices_bus_audio.SFX, muteado)
