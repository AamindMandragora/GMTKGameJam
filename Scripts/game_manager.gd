extends Node

var score = 0
@onready var water_image: TextureRect = $"../Water_Overlay/Water_Image"

func add_point():
	score += 1

func next_level(next_level_path: String):
	get_tree().change_scene_to_file(next_level_path)
	Globals.is_water_mode = false
	
func _process(delta: float) -> void:
	if Globals.is_water_mode:
		water_image.visible = true
	else:
		water_image.visible = false
