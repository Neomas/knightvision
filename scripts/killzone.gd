extends Area2D

#@onready var timer = $Timer

func _on_body_entered(body):
	if body.has_method("get_hit"):
		body.get_hit(1)
	

#
#func _on_timer_timeout():
	#Engine.time_scale = 1
	#get_tree().reload_current_scene() 
