extends CharacterBody2D
const heart = preload("res://scenes/heart.tscn")

@onready var ray_cast_right = $RayCast_Right
@onready var ray_cast_left = $RayCast_Left

@onready var animated_sprite = $AnimatedSprite2D
@onready var hit_timer = $HitTimer
#@onready var walls_node = %WallsNode



const WALL = preload("res://scenes/wall.tscn")

@export var health: float = 3
var SPEED: float = 200.0
var lookAt = "right"
var isFighting = false
var canHit = true
var target = null
var damage = 1

@onready var healthbar = $Healthbar

func _enter_tree():
	set_multiplayer_authority(name.to_int())

func _ready():
	if is_multiplayer_authority():
		updateHealth()

	if is_multiplayer_authority():
		$Camera2D.make_current()
	else:
		$Camera2D.enabled = false
		
func _process(_delta):
	if is_multiplayer_authority():
		var direction:Vector2 = Vector2.ZERO
		
		direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")

		direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up") 


		if direction.x < 0:
			animated_sprite.flip_h = true
			lookAt = "left"
		if direction.x > 0:
			animated_sprite.flip_h = false
			lookAt = "right"
				
		if !isFighting:
			if direction.x != 0:
				animated_sprite.play('run')
				
			if direction.y != 0:
				animated_sprite.play('run')
				
			if direction.x == 0 && direction.y == 0:
				animated_sprite.play('idle')
				
		
		if ray_cast_right.is_colliding() && lookAt == 'right':
			var itemRight = ray_cast_right.get_collider()
			print(itemRight)
			#print(itemRight.has_method("is_descructable"))
			
			if itemRight.has_method("is_descructable") && Input.is_action_just_pressed("primary"):
				#print("Hit")
				target = itemRight
				hit_timer.start()
				
			if itemRight.has_method("get_hit") && Input.is_action_just_pressed("primary"):
				itemRight.get_hit(1)

				
			
			
		if ray_cast_left.is_colliding() && lookAt == 'left':
			var itemLeft = ray_cast_left.get_collider()
			print(itemLeft)
			#print(itemLeft.has_method("is_descructable"))
			if itemLeft.has_method("is_descructable") && Input.is_action_just_pressed("primary"):
				target = itemLeft
				hit_timer.start()
			if itemLeft.has_method("get_hit") && Input.is_action_just_pressed("primary"):
				itemLeft.get_hit(1)
				
		
	#		Roll and slice
		if Input.is_action_pressed("primary", true):
			isFighting = true
			if direction.x != 0 || direction.y != 0:
				animated_sprite.play('roll')
				SPEED = 300
			else:
				animated_sprite.play('slice')
				SPEED = 200
			
		if Input.is_action_just_pressed("secondary"):
			var wallBlock = WALL.instantiate()
			var wall_nodes = get_tree().get_first_node_in_group("WallsNode")
			var xPos = position.x
			if lookAt == "right":
				xPos = ceil(position.x / 16) * 16 + 16
			if lookAt == "left":
				xPos = floor(position.x / 16) * 16 - 16
			var wallPostion = Vector2(xPos, floor(position.y / 16) * 16)
		
			
			if lookAt == 'left':
				if !ray_cast_left.is_colliding():
					wallBlock.position = wallPostion
					print(wallBlock)
					print(wallPostion)
					print( wall_nodes)
					wall_nodes.add_child(wallBlock)
				else:
					print("THERE'S A BLOCK ALREADY")
			if lookAt == "right":
				if !ray_cast_right.is_colliding():
					wallBlock.position = wallPostion
					print(wallBlock)
					print(wallPostion)
					print( wall_nodes)
					
					wall_nodes.add_child(wallBlock)
				else:
					print("THERE'S A BLOCK ALREADY")
				
			
	#		Primary Reset	
		if Input.is_action_just_released("primary"):
			hit_timer.stop()
			isFighting = false
			SPEED = 200
		
		velocity = direction * SPEED
		
		move_and_slide()

func get_hit(number: float):
	if health > 0:
		health = health - number
		updateHealth()
	if health == 0: 
		death()


	

func _on_hit_timer_timeout():
	var wall_nodes = get_tree().get_first_node_in_group("WallsNode")
	if target.has_method("is_descructable"):
		if lookAt == "right" && ray_cast_right.get_collider() != target:
			return
		if lookAt == "left" && ray_cast_left.get_collider() != target:
			return
		if target.health == 0 || target.health < 0 || target.health - damage == 0: 
			wall_nodes.remove_child(target)
			return
			
		if target.health > 0:
			target.get_hit(damage)


func death():
	position = Vector2(0,0)
	health = 3
	updateHealth()
	visible = true
	
func updateHealth():
	var children = healthbar.get_children()
	for child in children:
		child.free()

	for n in range(health):
		var heartItem = heart.instantiate()
		var heartPosition = Vector2(n * 8, 0)
		heartItem.position = heartPosition
		healthbar.add_child(heartItem)
