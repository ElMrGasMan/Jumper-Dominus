class_name MovimientoPlataforma
extends KinematicBody


export(String, "Movimiento_ZPositivo", "Movimiento_XPositivo", "Movimiento_ZNeg", "Movimiento_XNeg") var vector_movimiento
export var tiempo_timer: float = 2.0

var movimiento: Vector3 = Vector3.ZERO


func _ready() -> void:
	$Timer.wait_time = tiempo_timer
	match vector_movimiento:
		
		"Movimiento_ZPositivo":
			movimiento = Vector3(0.0, 0.0, 2.0)
		
		"Movimiento_XPositivo":
			movimiento = Vector3(2.0, 0.0, 0.0)
		
		"Movimiento_ZNeg":
			movimiento = Vector3(0.0, 0.0, -2.0)
		
		"Movimiento_XNeg":
			movimiento = Vector3(-2.0, 0.0, 0.0)

# warning-ignore:unused_argument
func _physics_process(delta: float) -> void:
# warning-ignore:return_value_discarded
	move_and_slide(movimiento, Vector3.ZERO)


func _on_Timer_timeout() -> void:
	movimiento *= -1
