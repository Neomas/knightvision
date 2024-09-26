extends Node2D

const SPEED = 60

var directionX = 1
var directionY = 1



@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var animated_sprite = $AnimatedSprite2D
@onready var ray_cast_bottom = $RayCastBottom
@onready var ray_cast_top = $RayCastTop

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ray_cast_top.is_colliding():
		directionY = 1
	if ray_cast_bottom.is_colliding():
		directionY = -1
	if ray_cast_right.is_colliding():
		directionX = -1
		animated_sprite.flip_h = true
	if ray_cast_left.is_colliding():
		directionX = 1
		animated_sprite.flip_h = false
	animated_sprite.play("sidewalk")
	position.x += directionX * SPEED * delta
	
