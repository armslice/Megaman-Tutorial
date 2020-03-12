# Megaman-Tutorial
# https://github.com/Armslice/Megaman-Tutorial

## HTML5 Deploy:
### https://megaman-tutorial.netlify.com

## Download Godot:
### https://godotengine.org/download

## Number By Color All Code Followthrough:  [Google Doc](https://docs.google.com/document/d/17_708wYdpQQjCvqxompUCOMqtMxhsSnsNSRo1mf8v6c/edit?usp=sharing)

### 0. Setup:
	Project Settings:
	
	General:
		Display > Window
          Size: 256x240, Test Width/Height: 768x720 
          Stretch mode: 2d
          Aspect: keep
		Rendering > Quality Depth>HDR: disable 
        Rendering > Environment > Background color
	Input map: movement, jump, shoot
	Autoload: Tools.gd, ref.gd

### 1. Creating the Debug console
	-Scripting basics: what is GDscript? vars, program control, get_node(string) and $ sugar, built-in functions, "Search Help" is your friend!!
	-Scene tree: Scenes, parent, child, Node2D, inheritance, Main Scene
	-Editor tools: Select, Move, Rotate, locking children (label), 
	-CanvasLayer
	-Life cycle Ready/Process and onready vars, set_process(true)
	-Functions: game.debug(text), typeof checking, variable basics
	-Visibility - modulate vs self modulate
	-input basics Input function vs Input in process, 		set_process_input(true)
	-game.debug(“Hello Godot”)

### 2. Creating the Player<Character> 
    -Player/Character script and inheritance
	-Kinematic Body
	-Collision Shape
	-Camera
	-pitYLevel / Camera.limit_bottom

### 3. Animated Sprite
	- Create 
	- Reimport : filter off
    Animations:
        stand, walk, jump, fall, shoot_stand, shoot_walk, shoot_jump, shoot_fall, die, hit

### 4. TileMap / Tileset
    Exporting a tileset .tres file 
    (we will have this premade but I will quickly show
    how it is generated)
    Sprite Texture Region
    kad

### 5. Player input/ velociy movement/friction Playing Animation
	

### 6. GRAVITY/JUMPING: Raycast, jump forces, animation for jump/fall
    -sign function determines direction of velocity, returns 1 or -1

### 7. Bullets: 
	Area2D, translate function, preload and instance, 
	Signals: Area2D: body_entered / VisibilityNotifier2D: 	screen_exited, position2D, global_position, 
	add_child, Timer, yield function, ternary operation for shootAnim

### 8. Enemies
	AI, walking - holeCheck, blockCheck raycast
	Death, fadeOut tools tween, yield
	hit, AnimationPlayer : flash

### 9. Player hit / lifebar / Death
	AnimationPlayer with hit sprite animation 
	(Animation player vs Sprite animations)
	Player death.
	Fall death.

### 10. Extra Credit Homework!
	
	Enemy Defense
	moving platforms
	End Game
	Powerup drops
	Music/SFX
    Bootsplash / Instruction screen


### Resources:
	Sprites:
		www.spriters-resource.com
		www.opengameart.org


