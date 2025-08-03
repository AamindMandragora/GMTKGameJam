extends Node

var score = 0

func add_point():
	score += 1

func next_level(next_level_path: String):
	get_tree().change_scene_to_file(next_level_path)
