extends AnimatableBody2D


var max_health: float = 3
var health: float = 4
@onready var healthIndicator = $Health
@onready var sprite_2d = $Sprite2D

func is_descructable():
	pass
	
func get_hit(number: float):
	if health > 0:
		healthIndicator.visible = true
		health = health - number

		var scaleItem = health / max_health
		var rect = Rect2(321.984, 33.75, 44.449 * scaleItem, 13.064)
		healthIndicator.set_region_rect(rect)

	
	
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta):
	#if health == 0 || health < 0:
		#queue_free()
