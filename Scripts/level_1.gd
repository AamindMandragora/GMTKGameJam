extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"Fade Transition/Fade In".play("fade")
