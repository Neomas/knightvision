extends AnimatableBody2D

var max_health: float = 3
var health: float = 4
@onready var healthIndicator = $Health
@onready var sprite_2d = $Sprite2D

func is_descructable():
	pass
	
#func get_hit(number: float):
	#healthIndicator.visible = true
	#health = health - number
#
	#var scaleItem = health / max_health
	#var rect = Rect2(63.59, 64.039, 48.232 * scaleItem, 16.586)
#
	#healthIndicator.set_region_rect(rect)
#
	#
	#print("Auwtch!")
	#print("health:", health)
	
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if health == 0 || health < 0:
		queue_free()
