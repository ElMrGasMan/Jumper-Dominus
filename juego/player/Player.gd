class_name Jugador 
extends KinematicBody


const direccion_arriba: Vector3 = Vector3.UP

enum {SUELO, AIRE}

export var gravedad: float = 1.2
export var impulso_externo: float = 18.0
export var impulso_salto: float = 2.0
export var velocidad_maxima: Vector2 = Vector2(6.0, 16.0)

var movimiento: Vector3 = Vector3.ZERO
var vector_snap: Vector3 = Vector3.DOWN
var direccion_vista_pl: Vector2
var salto_interrumpido = false
var accion_saltando = false
var accion_cayendo = false
var accion_disparando = false

onready var sosten_camara: SpringArm = $SostenedorCamara
onready var armadura: Spatial = $Armature
onready var arbol_animaciones: AnimationTree = $ArbolAnimaciones
onready var linterna: SpotLight = $LinternaModeloMKII
onready var colisionador: CollisionShape = $CollisionCapsule


# warning-ignore:unused_argument
func _process(delta: float) -> void:
	sosten_camara.translation = translation


# warning-ignore:unused_argument
func _physics_process(delta: float) -> void:
	movimiento_vert()
	movimiento_horiz()
	movimiento = move_and_slide_with_snap(movimiento, vector_snap, direccion_arriba, true)
	
	direccion_vista_pl = Vector2(movimiento.z, movimiento.x)
	
	if direccion_vista_pl.length() > 0:
		armadura.rotation.y = direccion_vista_pl.angle()
		colisionador.rotation.y = direccion_vista_pl.angle()
	
	if accion_disparando:
		linterna.rotation.y = armadura.rotation.y - 3.141592


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("disparo") and accion_disparando == false:
		accion_disparando = true
		arbol_animaciones.set_mezcla_disparo_valor(1)
		linterna.light_energy = 15
	
	elif event.is_action_pressed("disparo") and accion_disparando == true:
		accion_disparando = false
		arbol_animaciones.set_mezcla_disparo_valor(0)
		linterna.light_energy = 0


func movimiento_vert() -> void:
	if not is_on_floor():
		movimiento.y -= gravedad
		movimiento.y = clamp(movimiento.y, -velocidad_maxima.y, impulso_externo)
		
		if Input.is_action_just_released("saltar"):
			salto_interrumpido = true
	
	else: 
		accion_saltando = false
	
	var tocando_suelo: bool = is_on_floor() and vector_snap == Vector3.ZERO
	var iniciando_salto: bool = is_on_floor() and Input.is_action_just_pressed("saltar")
	
	if iniciando_salto:
		arbol_animaciones.set_transicion_suelo_aire_valor(AIRE)
		arbol_animaciones.set_mezcla_jump_fall_valor(0)
		vector_snap = Vector3.ZERO
		accion_saltando = true
		salto_interrumpido = false
		accion_cayendo = false
	
	elif tocando_suelo:
		arbol_animaciones.set_transicion_suelo_aire_valor(SUELO)
		vector_snap = Vector3.DOWN
	
	if movimiento.y >= velocidad_maxima.y:
		salto_interrumpido = true
	
	if Input.is_action_pressed("saltar") and accion_saltando and not salto_interrumpido:
		movimiento.y += impulso_salto
	
	if movimiento.y <= 0 and not accion_cayendo:
		accion_cayendo = true
		
		for i in range(1, 11, 1):
			arbol_animaciones.set_mezcla_jump_fall_valor(i * 0.1)


func movimiento_horiz() -> void:
	movimiento.x = calc_direccion().x * velocidad_maxima.x 
	movimiento.z = calc_direccion().z * velocidad_maxima.x


func calc_direccion() -> Vector3:
	var direccion: Vector3 = Vector3.ZERO
	direccion.x = Input.get_action_strength("moverse_derecha") - Input.get_action_strength("moverse_izquierda")
	direccion.z = Input.get_action_strength("moverse_atras") - Input.get_action_strength("moverse_adelante")
	direccion = direccion.rotated(Vector3.UP, sosten_camara.rotation.y).normalized()
	arbol_animaciones.set_mezcla_idle_andar_valor(direccion.length())
	
	return direccion


func respawn() -> void:
	DataDelJugador.restar_vida()
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()
