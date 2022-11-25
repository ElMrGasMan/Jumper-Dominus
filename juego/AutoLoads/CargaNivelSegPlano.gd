class_name CargaNivelSegundoPlano
extends Control


var hilo: Thread = null
var apretar_para_iniciar: bool = false
var escena_precargada: Node = null

onready var barra_carga: ProgressBar = $ProgresoDeCarga
onready var alerta_carga_completa: Label = $OracionCarga
onready var animaciones: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	barra_carga.visible = false
	alerta_carga_completa.visible = false


# warning-ignore:unused_argument
func _unhandled_input(event: InputEvent) -> void:
	if apretar_para_iniciar:
		get_tree().current_scene.queue_free()
		get_tree().current_scene = null
		get_tree().root.add_child(escena_precargada)
		get_tree().current_scene = escena_precargada
		
		barra_carga.visible = false
		alerta_carga_completa.visible = false
		apretar_para_iniciar = false
		animaciones.stop()


func cargar_nivel_siguiente(nivel: String) -> void:
	hilo = Thread.new()
# warning-ignore:return_value_discarded
	hilo.start(self, "cargar_hilo", nivel, 2)
	raise()
	barra_carga.visible = true
	DataDelJugador.cargando_partida = false


func cargar_hilo(nivel: String) -> void:
	var recurso_interactivo: ResourceInteractiveLoader = ResourceLoader.load_interactive(nivel)
	var total_partes: int = recurso_interactivo.get_stage_count()
	
	barra_carga.max_value = total_partes
	
	var resultado_carga: int = OK
	var recurso_cargado: Resource = null
	
	while resultado_carga == OK:
		barra_carga.value = recurso_interactivo.get_stage()
		resultado_carga = recurso_interactivo.poll()
		
		if resultado_carga != OK:
			
			if resultado_carga == ERR_FILE_EOF:
				recurso_cargado = recurso_interactivo.get_resource()
				barra_carga.value = total_partes
			
			else:
				print("Ocurrió un error en la carga del Nivel/Recurso")
	
	call_deferred("carga_completa_nivel", recurso_cargado)


func carga_completa_nivel(recurso: Resource) -> void:
	alerta_carga_completa.visible = true
	animaciones.play("Titilar")
	hilo.wait_to_finish()
	escena_precargada = recurso.instance()
	apretar_para_iniciar = true
