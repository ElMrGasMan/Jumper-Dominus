class_name GuardarCargar
extends Node


enum{PARTIDA, CONFIGURACION}


func guardar_datos_config() -> int:
	
	if not OS.get_name() in DatosConfiguracion.OS_ADMITIDOS_PARA_GUARDADO:
		return -1
	
	var archivo_datos: DatosAjustesUsuarioGuardados = DatosAjustesUsuarioGuardados.new()
	archivo_datos.pantalla_completa = OS.window_fullscreen
	archivo_datos.pantalla_resolucion = OS.window_size
	archivo_datos.buses_volumen = {
		"master": AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")),
		"sfx": AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")),
		"musica": AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Musica")),
	}
	
	var resultado: int = ResourceSaver.save(seleccionar_ruta(CONFIGURACION), archivo_datos)
	
	return resultado


func guardar_datos_partida() -> int:
	
	if not OS.get_name() in DatosConfiguracion.OS_ADMITIDOS_PARA_GUARDADO:
		return -1
	
	var ruta_guardado: String = seleccionar_ruta(PARTIDA)
	var datos_guardar: DatosJuegoGuardado = DatosJuegoGuardado.new()
	
	datos_guardar.vidas = DataDelJugador.vidas
	datos_guardar.monedas = DataDelJugador.monedas
	datos_guardar.nivel_actual = DataDelJugador.nivel_actual
	datos_guardar.num_nivel_actual = DataDelJugador.num_nivel_actual
	datos_guardar.nivel_siguiente = DataDelJugador.nivel_siguiente
	datos_guardar.puntaje_total = DataDelJugador.puntaje_total
	
	var resultado: int = ResourceSaver.save(ruta_guardado, datos_guardar)
	
	return resultado


func cargar_datos_configuracion() -> void:
	var ruta_cargado: String = seleccionar_ruta(CONFIGURACION)
	var directorio: Directory = Directory.new()
	
	if not directorio.file_exists(ruta_cargado):
# warning-ignore:return_value_discarded
		guardar_datos_config()
	
	else:
		var datos: Resource = load(ruta_cargado)
		
		OS.window_fullscreen = datos.pantalla_completa
		OS.window_size = datos.pantalla_resolucion
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), datos.buses_volumen.master)
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), datos.buses_volumen.sfx)
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Musica"), datos.buses_volumen.musica)
		
		var size_pantalla := OS.get_screen_size()
		OS.set_window_position((size_pantalla - datos.pantalla_resolucion) * 0.5)


func cargar_datos_partida() -> void:
	var ruta_cargar: String = seleccionar_ruta(PARTIDA)
	var datos_cargar: Resource = load(ruta_cargar)
	
	DataDelJugador.vidas = datos_cargar.vidas
	DataDelJugador.monedas = datos_cargar.monedas
	DataDelJugador.nivel_actual = datos_cargar.nivel_actual
	DataDelJugador.num_nivel_actual = datos_cargar.num_nivel_actual
	DataDelJugador.nivel_siguiente = datos_cargar.nivel_siguiente
	DataDelJugador.puntaje_total = datos_cargar.puntaje_total


func chequear_existencia_datos_guardados() -> bool:
	var ruta_cargado: String = seleccionar_ruta(PARTIDA)
	var directorio: Directory = Directory.new()
	
	if not directorio.file_exists(ruta_cargado):
		return false
	
	else:
		return true


func seleccionar_ruta(archivo: int) -> String:
	var ruta_guardado: String
	
	if OS.is_debug_build():
		ruta_guardado = DatosConfiguracion.RUTA_GUARDADO_PARA_DEBUG
	
	else:
		ruta_guardado = DatosConfiguracion.RUTA_GUARDADO_PARA_RELEASE
	
	chequear_existencia_directorio(ruta_guardado)
	
	match archivo:
		
		PARTIDA:
			ruta_guardado += DatosConfiguracion.NOMBRE_ARCHIVO_DATOS
		
		CONFIGURACION:
			ruta_guardado += DatosConfiguracion.NOMBRE_ARCHIVO_CONFIGURACION
		
		_:
			printerr("Este tipo de archivo no existe webon")
	
	return ruta_guardado


func chequear_existencia_directorio(ruta: String) -> void:
	var dir = Directory.new()
	
	if not dir.dir_exists(ruta):
# warning-ignore:return_value_discarded
		Directory.new().make_dir_recursive(ruta)
