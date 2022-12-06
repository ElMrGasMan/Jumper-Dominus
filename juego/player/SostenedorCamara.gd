class_name SostenedorCamara
extends SpringArm


export var velocidad_mov_cam: Vector2 = Vector2(0.20, 0.20)
export var rango_rotacion_cam_x: Vector2 = Vector2(-90.0, 30.0)
export var camara_invertida_x: bool = false
export var camara_invertida_y: bool = false

var c : int = 0


func _ready() -> void:
	set_as_toplevel(true)
	velocidad_mov_cam *= camara_esta_invertida()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _unhandled_input(event: InputEvent) -> void:
	c += 1
	
	if event is InputEventMouseMotion:
		rotation_degrees.x += event.relative.y * velocidad_mov_cam.y
		rotation_degrees.x = clamp(rotation_degrees.x, rango_rotacion_cam_x.x, rango_rotacion_cam_x.y)
		
		rotation_degrees.y += event.relative.x * velocidad_mov_cam.x


func camara_esta_invertida() -> Vector2:
	var vector_camara = Vector2.ONE
	
	if camara_invertida_x:
		vector_camara.x = -1
	
	if camara_invertida_y:
		vector_camara.y = -1
	
	return vector_camara
