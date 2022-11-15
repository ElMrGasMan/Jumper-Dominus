class_name SostenedorCamara
extends SpringArm


export var velocidad_mov_cam: float = 0.08
export var rango_rotacion_cam_x: Vector2 = Vector2(-90.0, 30.0)
export var rango_rotacion_cam_y: Vector2 = Vector2(0.0, 360.0)

var c : int = 0


func _ready() -> void:
	set_as_toplevel(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _unhandled_input(event: InputEvent) -> void:
	c += 1
	
	if event is InputEventMouseMotion:
		rotation_degrees.x += event.relative.y * velocidad_mov_cam
		rotation_degrees.x = clamp(rotation_degrees.x, rango_rotacion_cam_x.x, rango_rotacion_cam_x.y)
		
		rotation_degrees.y += event.relative.x * velocidad_mov_cam
		rotation_degrees.y = clamp(rotation_degrees.y, rango_rotacion_cam_y.x, rango_rotacion_cam_y.y)
	
	#TODO: DEBUG ONLY
	
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
