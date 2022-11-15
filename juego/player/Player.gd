class_name Jugador 
extends KinematicBody


const direccion_arriba: Vector3 = Vector3.UP

export var gravedad: float = 1.2
export var velocidad_maxima: Vector2 = Vector2(6.0, 16.0)
export var impulso_externo: float = 18.0
export var impulso_salto: float = 2.0

var movimiento: Vector3 = Vector3.ZERO
var salto_interrumpido = false
var accion_saltando = false
var vector_snap: Vector3 = Vector3.DOWN
var direccion_vista_pl: Vector2

onready var sosten_camara: SpringArm = $SostenedorCamara
onready var armadura: Spatial = $Armature


func _ready() -> void:
	pass


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
		vector_snap = Vector3.ZERO
		accion_saltando = true
		salto_interrumpido = false
	
	elif tocando_suelo:
		vector_snap = Vector3.DOWN
	
	if movimiento.y >= velocidad_maxima.y:
		salto_interrumpido = true
	
	if Input.is_action_pressed("saltar") and accion_saltando and not salto_interrumpido:
		movimiento.y += impulso_salto


func movimiento_horiz() -> void:
	movimiento.x = calc_direccion().x * velocidad_maxima.x 
	movimiento.z = calc_direccion().z * velocidad_maxima.x


func calc_direccion() -> Vector3:
	var direccion: Vector3 = Vector3.ZERO
	direccion.x = Input.get_action_strength("moverse_derecha") - Input.get_action_strength("moverse_izquierda")
	direccion.z = Input.get_action_strength("moverse_atras") - Input.get_action_strength("moverse_adelante")
	direccion = direccion.rotated(Vector3.UP, sosten_camara.rotation.y).normalized()
	
	return direccion
