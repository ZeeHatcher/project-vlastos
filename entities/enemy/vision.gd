tool
extends Node2D


func _draw():
	var center = Vector2()
	var radius = owner.detection_range
	var start_angle = deg2rad(-45)
	var end_angle = deg2rad(45)
	var num_segments = 16.0
	var color = Color(1, 1, 1)
	var fill_color = Color(1, 1, 1, 1)
	
	var points = []
	for i in range(num_segments + 1):
		var angle = lerp(start_angle, end_angle, i / num_segments)
		points.append(center + Vector2(cos(angle), sin(angle)) * radius)
	
	points.append(center)
	
	draw_colored_polygon(points, fill_color)
	draw_arc(center, radius, start_angle, end_angle, radius / num_segments, color)
