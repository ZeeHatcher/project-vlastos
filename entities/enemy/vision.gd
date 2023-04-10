tool
extends Node2D


func _draw():
	# Set the center and radius of the semicircle
	var center = Vector2()
	var radius = owner.detection_range
	
	# Set the start and end angles of the semicircle
	var start_angle = deg2rad(-45)
	var end_angle = deg2rad(45)
	
	# Set the number of line segments to use when drawing the arc
	var num_segments = 16.0
	
	# Set the color of the arc and its fill
	var color = Color(1, 1, 1)
	var fill_color = Color(1, 1, 1, 1)
	
	# Create a list of points that define the semicircle
	var points = []
	for i in range(num_segments + 1):
		var angle = lerp(start_angle, end_angle, i / num_segments)
		print(angle)
		points.append(center + Vector2(cos(angle), sin(angle)) * radius)
	
	# Add the center point to the list of points
	points.append(center)
	
	# Draw the filled semicircle
	draw_colored_polygon(points, fill_color)
	draw_arc(center, radius, start_angle, end_angle, radius / num_segments, color)
	
	for p in points:
		draw_circle(p, 1, fill_color)
