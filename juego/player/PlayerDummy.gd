class_name JugadorFalso
extends KinematicBody


export var velocidad_rot: int = 15

onready var animaciones: AnimationPlayer = $AnimationPlayer
onready var armadura: Spatial = $Armature


func _ready() -> void:
	animaciones.play("run-cycle")


func _process(delta: float) -> void:
	armadura.rotation_degrees.y += velocidad_rot * delta
