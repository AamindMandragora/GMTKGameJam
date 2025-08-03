extends TextureRect

@onready var shader := material as ShaderMaterial

@export var scroll_speed := Vector2(0.25, 0)  # Scroll speed in UV units per second
var scroll_offset := Vector2.ZERO

func _process(delta: float) -> void:
	scroll_offset += scroll_speed * delta
	# Wrap around to keep UVs between 0 and 1 (optional but neat)
	scroll_offset.x = fmod(scroll_offset.x, 1.0)
	scroll_offset.y = fmod(scroll_offset.y, 1.0)
	
	shader.set_shader_parameter("scroll_offset", scroll_offset)
	shader.set_shader_parameter("alpha_factor", 0.3)
