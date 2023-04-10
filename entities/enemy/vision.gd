extends Node2D


func _draw():
	var center = Vector2()
	var radius = owner.detection_range
	
	var start_angle = deg2rad(-45)
	var end_angle = deg2rad(45)
	var num_segments = 16.0
	var colors = [Color.white]
	
	var points = []
	points.append(center)
	
	for i in range(num_segments + 1):
		colors.append(Color.transparent)
		var angle = lerp(start_angle, end_angle, i / num_segments)
		points.append(center + Vector2(cos(angle), sin(angle)) * radius)
	
	draw_polygon(points, colors)
