# Megaman-Tutorial
# https://github.com/Armslice/Megaman-Tutorial

## HTML5 Deploy:
### https://megaman-tutorial.netlify.com

## Download Godot:
### https://godotengine.org/download

## Number By Code By Color Followthrough:  [Google Doc](https://docs.google.com/document/d/17_708wYdpQQjCvqxompUCOMqtMxhsSnsNSRo1mf8v6c/edit?usp=sharing)

### 0. Setup:

Start Godot and create a new project by creating and selecting an new empty project folder.
Copy and paste the contents of Start Resources folder into that folder.

	Project>Project Settings:
	
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

Create a Node2D as your main scene, name it Game and save it, it will save as Game.tscn. This is the parent of all other objects in the game. You can try to run your scene now by clicking the play icon in the top right. You will be asked to select the main scene, select Game.tscn and an empty window of you game should now run. At this point you should see, the generic Godot splash screen and what ever the background color is set to in the Project Settings.

We attach scripts to game objects. There is add/delete script button next to search bar in the "Scene" tab (The Scene Tree) If its green it means the current selected object has no script and you can create a new script and start coding. Give Game a script. If you named your object properly the script will automatically have the same name as the object, in this case Game.gd.

For our very first child, Create a CanvasLayer for gui objects that are always on screen regardless of the camera. Lets name it Modal.

Inside of Modal, create a Panel, and inside the panel create a label. In code you can now access the label as $Modal/Panel/Label. Rename the panel to something distinct and now refer to them as that, lets use $Modal/DebugConsole/Label.

We can use this DebugConsole to see our game varibles in real time. You can do a print statement print(SomeVar), but that will only print the varible at that very moment. If you want a constant updated print out will do that with the Label by updating its "text" property. Start by calling "set_process(true)" in your ready function and create the "func _process(delta)" This is the function that runs each and every frame. Follow the "Code By Color" in the google doc for this section (cyan)

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
    
    Create a new scene Name it player.

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


