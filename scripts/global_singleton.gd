extends Node

#const heart = preload("res://scenes/heart.tscn")

#var health =  3

#func get_hit(number: float, healthbar, health):
	#if health > 0:
		#health = health - number
		#updateHealth(healthbar, health)
	#if health == 0: 
		#death(health)
	#
## Called when the node enters the scene tree for the first time.
#func updateHealth(healthbar, health):
	#var children = healthbar.get_children()
	#for child in children:
		#child.free()
#
	#for n in range(health):
		#var heartItem = heart.instantiate()
		#var heartPosition = Vector2(n * 8, 0)
		#heartItem.position = heartPosition
		#healthbar.add_child(heartItem)
		#
#func death(health):
	#get_tree().reload_current_scene() 
	#health = 3
