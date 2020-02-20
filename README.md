# Megaman-Tutorial
# https://github.com/Armslice/Megaman-Tutorial

## HTML5 Deploy:
### https://megaman-tutorial.netlify.com

## Download Godot:
### https://godotengine.org/download

## Number By Color All Code:
[Google Doc](Followthrough(https://docs.google.com/document/d/17_708wYdpQQjCvqxompUCOMqtMxhsSnsNSRo1mf8v6c/edit?usp=sharing)

### 0. Setup:
	Project Settings:
	
	General:
		Display > Window
          Size: 256x240, Test Width/Height: 768x720 
          Stretch mode: 2d
          Aspect: keep
		Rendering > Quality>HDR: disable 
        Rendering > Environment > Background color
	Input map: movement, jump, shoot
	Autoload: Tools.gd, ref.gd

### 1. Creating the Debug console
	-Scripting basics: vars, program control, get_node(string) and $ sugar
	-Scene tree basics, 
	-Editor tools: locking children (label), 
	-CanvasLayer
	-Life cycle Ready/Process and onready vars, set_process(true)
	-Functions: game.debug(text), typeof checking, variable basics
	-Visibility - modulate vs self modulate
	-input basics Input function vs Input in process, 		set_process_input(true)
	-game.debug(“Hello Godot”)

### 2. Creating the Player<Character> 
	-Kinematic Body
	-Collision Shape
	-Camera
	-pitYLevel / Camera.limit_bottom

### 3. Animated Sprite
	- Create 
	- Reimport : filter off

### 4. TileMap Sprite Texture Region

### 5. Player input/ velociy movement/friction Playing Animation
	-Player script and inheritance
	-Tools.gd and auto import global scripts (ref.gd / dialog.gd)

### 6. GRAVITY/JUMPING: Raycast, jump forces, animation for jump/fall

### 7. Bullets: 
	Area2D, translate function, preload and instance, 
	Signals: Area2D: body_entered / VisibilityNotifier2D: 	screen_exited, position2D, global_position, 
	add_child, Timer, yield function, ternary operation for shootAnim

### 8. Enemies
	AI, walking - holeCheck, blockCheck raycast
	Death, fadeOut tools tween, yield
	hit, AnimationPlayer : flash

### 9. Player hit / lifebar
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


### Resources:
	Sprites:
		www.spriters-resource.com
		www.opengameart.org


