extends Node2D

var peer = ENetMultiplayerPeer.new()
@export var player_scene: PackedScene
@onready var join = $Join
@onready var host = $Host


func _on_host_pressed():
	peer.create_server(8080)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_add_player)
	_add_player()
	join.visible = false
	host.visible = false

func _add_player(id =1):
	var player = player_scene.instantiate()
	player.name = str(id)
	call_deferred("add_child", player)
	


func _on_join_pressed():
	peer.create_client("localhost", 8080)
	multiplayer.multiplayer_peer = peer
	
	join.visible = false
	host.visible = false
	
