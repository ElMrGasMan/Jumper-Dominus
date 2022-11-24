class_name GuardarCargar
extends Node


func guardar_formato_json(datos_para_guardar: Dictionary) -> int:
	
	if not OS.get_name() in DatosConfiguracion.OS_ADMITIDOS_PARA_GUARDADO:
		return -1
	
	var archivo: File = File.new()
	var resultado: int = archivo.open(seleccionar_ruta(".json"), File.WRITE)
	
	if resultado == OK:
		archivo.store_line(to_json(datos_para_guardar))
		archivo.close()
	
	return resultado


func guardar_formato_tres(datos_para_guardar: Dictionary) -> int:
	
	if not OS.get_name() in DatosConfiguracion.OS_ADMITIDOS_PARA_GUARDADO:
		return -1
	
	var datos: DatosJuegoGuardado = DatosJuegoGuardado.new()
	datos.nombre = datos_para_guardar.nombre
	
	var resultado: int = ResourceSaver.save(seleccionar_ruta(".tres"), datos)
	
	return resultado


func cargar_formato_json() -> Dictionary:
	
	if not OS.get_name() in DatosConfiguracion.OS_ADMITIDOS_PARA_GUARDADO:
		return {}
	
	var archivo: File = File.new()
	var resultado: int = archivo.open(seleccionar_ruta(".json"), File.READ)
	
	if resultado == OK:
		var datos_cargados: Dictionary = parse_json(archivo.get_line())
		archivo.close()
		
		return datos_cargados
	
	else:
		return {}


func seleccionar_ruta(extension: String) -> String:
	var ruta_guardado: String
	
	if OS.is_debug_build():
		ruta_guardado = DatosConfiguracion.RUTA_GUARDADO_PARA_DEBUG
	
	else:
		ruta_guardado = DatosConfiguracion.RUTA_GUARDADO_PARA_RELEASE
	
	chequear_existencia_directorio(ruta_guardado)
	ruta_guardado += DatosConfiguracion.NOMBRE_ARCHIVO_DATOS + extension
	
	return ruta_guardado


func chequear_existencia_directorio(ruta: String) -> void:
	var dir = Directory.new()
	
	if not dir.dir_exists(ruta):
# warning-ignore:return_value_discarded
		Directory.new().make_dir_recursive(ruta)
