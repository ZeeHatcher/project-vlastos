extends Area2D


signal collected


func _on_Key_body_entered(body):
	emit_signal("collected")
	queue_free()
