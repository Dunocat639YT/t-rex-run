extends Node

var stump_scene = preload("res://scenes/stump.tscn")
var rock_scene = preload("res://scenes/rock.tscn")
var barrel_scene = preload("res://scenes/barrel.tscn")
var bird_scene = preload("res://scenes/bird.tscn")
var obstacle_types := [stump_scene, rock_scene, barrel_scene]
var osbtacles : Array
var bird_heights := [200, 390]

const DINO_START_POS := Vector2i(150, 485)
const CAM_START_POS := Vector2i(576, 324)
var score : int
const SCORE_MODIFIER : int = 10
var speed : float
const START_SPEED : float = 2.0
const MAX_SPEED : int = 8
const SPEED_MODIFIER : int = 5000
var screen_size : Vector2i
var game_running : bool
var last_obs


func _ready() -> void:
	screen_size = get_window().size
	new_game()
	

func new_game():
	# Reset variables
	score = 0
	show_score()
	game_running = false
	
	# Reset the nodes
	$Dino.position = DINO_START_POS
	$Dino.velocity = Vector2i(0, 0)
	$Camera2D.position = CAM_START_POS
	$Ground.position = Vector2i(0, 0)
	
	# Reset HUD
	$HUD.get_node("StartLabel").show()
	
	
func _process(delta: float) -> void:
	if game_running:
		speed = START_SPEED + score / SPEED_MODIFIER
		if speed > MAX_SPEED:
			speed = MAX_SPEED
			
			
	generate_osbs()
		
		# Move dino and camera
		$Dino.position.x += speed
		$Camera2D.position.x += speed
		
		#Update score
		score += speed
		show_score()
		
		# Update ground position
		if $Camera2D.position.x - $Ground.position.x > screen_size.x * 1.5:
			$Ground.position.x += screen_size.x 
	else:
		if Input.is_action_pressed("ui_accept"):
			game_running = true
			$HUD.get_node("StartLabel").hide()

func generate_obs():
	# Generate ground obstacles
	if obstacles.is_empty():
		var obs_type = obstacle_types[randi() % obstacle_types.size()]
	
func show_score():
	$HUD.get_node("ScoreLabel").text = "SCORE: " + str(score / SCORE_MODIFIER)
