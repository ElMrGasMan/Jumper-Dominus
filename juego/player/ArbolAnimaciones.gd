class_name ArbolAnimacionesPlayer
extends AnimationTree


func get_mezcla_idle_andar_valor() -> float:
	return get("parameters/MezclaIdleRun/blend_amount")


func set_mezcla_idle_andar_valor(valor: float) -> void:
	set("parameters/MezclaIdleRun/blend_amount", valor)


func get_mezcla_jump_fall_valor() -> float:
	return get("parameters/MezclaJumpFall/blend_amount")


func set_mezcla_jump_fall_valor(valor: float) -> void:
	set("parameters/MezclaJumpFall/blend_amount", valor)


func get_transicion_suelo_aire_valor() -> int:
	return get("parameters/TransicionSueloAire/current")


func set_transicion_suelo_aire_valor(valor: int) -> void:
	set("parameters/TransicionSueloAire/current", valor)


func get_mezcla_disparo_valor() -> float:
	return get("parameters/MezclaDisparo/blend_amount")


func set_mezcla_disparo_valor(valor: float) -> void:
	set("parameters/MezclaDisparo/blend_amount", valor)
