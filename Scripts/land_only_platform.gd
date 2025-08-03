extends AnimatableBody2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Globals.is_water_mode:
		visible = false
		$CollisionShape2D.disabled = true
	else:
		visible = true
		$CollisionShape2D.disabled = false
