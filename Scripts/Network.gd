extends Node


const DEFAULT_PORT = 8190 #whatever
@onready var address = "127.0.0.1"
var port = DEFAULT_PORT
var status =""



func _ready():
	# Connect all the callbacks related to networking.
	get_tree().connect("peer_connected", Callable(self, "_player_connected"))
	get_tree().connect("peer_disconnected", Callable(self, "_player_disconnected"))
	get_tree().connect("connected_to_server", Callable(self, "_connected_ok"))
	get_tree().connect("connection_failed", Callable(self, "_connected_fail"))
	get_tree().connect("server_disconnected", Callable(self, "_server_disconnected"))






#### Network callbacks from SceneTree ####

# Callback from SceneTree.
func _player_connected(_id):
	# Someone connected, start the game!
	#var pong = load("res://pong.tscn").instance()
	# Connect deferred so we can safely erase it from the callback.
	#pong.connect("game_finished", self, "_end_game", [], CONNECT_DEFERRED)
	print("player connected")
	if get_tree().is_server():
	# For the server, give control of player 2 to the other peer.
		set_multiplayer_authority(get_tree().get_peers()[0])
	else:
	# For the client, give control of player 2 to itself.
		set_multiplayer_authority(get_tree().get_unique_id())
	print("unique id: ", get_tree().get_unique_id())
	#get_tree().get_root().add_child(pong)
	if global.active_console != null:
		global.active_console.printout("valid opponent found! Now attacking:\n"+str(_id))



func _player_disconnected(_id):
	if get_tree().is_server():
		_end_game("Client disconnected")
	else:
		_end_game("Server disconnected")


# Callback from SceneTree, only for clients (not server).
func _connected_ok():
	if global.active_console != null:
		global.active_console.printout("Connected to valid opponent! Attack")
	pass # We don't need this function.


# Callback from SceneTree, only for clients (not server).
func _connected_fail():
	_set_status("Couldn't connect", false)
	
	get_tree().set_multiplayer_peer(null) # Remove peer.
	
	#host_button.set_disabled(false)
	#join_button.set_disabled(false)


func _server_disconnected():
	_end_game("Server disconnected")

##### Game creation functions ######

func _end_game(with_error = ""):
	if has_node("/root/Pong"):
		# Erase immediately, otherwise network might show errors (this is why we connected deferred above).
		get_node("/root/Pong").free()
	
	get_tree().set_multiplayer_peer(null) # Remove peer.
	#host_button.set_disabled(false)
	#join_button.set_disabled(false)
	
	_set_status(with_error, false)


func _set_status(text, isok):
	# Simple way to show status.
	if isok:
		#status_ok.set_text(text)
		#status_fail.set_text("")
		status = text
		pass
	else:
		#status_ok.set_text("")
		#status_fail.set_text(text)
		status = text
		pass
	return status


func _on_host_pressed():
	var host = ENetMultiplayerPeer.new()
	#host.set_compression_mode(ENetMultiplayerPeer.COMPRESS_RANGE_CODER)
	var err = host.create_server(port, 1) # Maximum of 1 peer, since it's a 2-player game.
	if err != OK:
		# Is another server running?
		_set_status("Can't host, address in use.",false)
		return
	
	get_tree().set_multiplayer_peer(host)
	#host_button.set_disabled(true)
	#join_button.set_disabled(true)
	_set_status("Waiting for player...", true)


func _on_join_pressed():
	var ip = address
	if not ip.is_valid_ip_address():
		_set_status("IP address is invalid", false)
		return
	
	var host = ENetMultiplayerPeer.new()
	#host.set_compression_mode(ENetMultiplayerPeer.COMPRESS_RANGE_CODER)
	#host.create_client(ip, port)
	get_tree().set_multiplayer_peer(host)
	
	_set_status("Connecting...", true)
	
	
	#USE FUNCTIONS
func sendText(function,arg):
	rpc("receiveText",function,arg)
	
@rpc("any_peer") func receiveText(function,arg):
	match function:
		"chat":
			if global.active_console != null:
				global.active_console.printout(arg)
		"dmg":
			global.dmg(arg)
			pass
		"youwon":
			global.win()
		"spam":
			global.desktop.spamAds(int(arg))
		"tip":
			if global.hackradar != null:
				var p
				match arg:
					"ssh":
						p=0
					"ftp":
						p=1
					"http":
						p=2
				global.hackradar.setTarget(p)





