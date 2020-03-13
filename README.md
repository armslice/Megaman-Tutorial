# Megaman-Tutorial
# https://github.com/Armslice/Megaman-Tutorial

## HTML5 Deploy:
### https://megaman-tutorial.netlify.com

## Download Godot:
### https://godotengine.org/download

## Number By Code By Color Followthrough:  [Google Doc](https://docs.google.com/document/d/17_708wYdpQQjCvqxompUCOMqtMxhsSnsNSRo1mf8v6c/edit?usp=sharing)

### 0. Setup:

Start Godot and create a new project by creating and selecting an new empty project folder.
Copy and paste the contents of Start Resources folder into that new project folder.

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

In the top left you will find the scene tab. Here you can create all sorts of Nodes, the building block for the game objects in godot. In an empty scene you will get a list of suggestions. You can also press the [+] icon to create any type of the different nodes in Godot. Create a Node2D as the root of your first scene, name it Game and save it, it will save as Game.tscn. This is the parent of all other objects in the game. You can try to run your scene now by clicking the play icon in the top right. You will be asked to select the main scene, select Game.tscn and an empty window of you game should now run. At this point you should see, the generic Godot splash screen and what ever the background color is set to in the Project Settings.

    This tutorial will reference the default layout of Godot which can be modified. If you can't find something according to these directions than you may have inadvertently changed the layout. You can reset the layout in the Editor menu >Editor Layout>Default

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

Create a new scene. Create the root as a KinematicBody2D. Change the name of this node to Player and save.

The player object will inherit from a Character script. Essentially it has two scripts, The Player.gd script which inherits all variables and functions from Character.gd. The character script is not attached to any object so we will create it from scracth. Select the script tab from the center mode control (2D,3D,Script,AssetLib). 
    For 2d games we will bounce from 2d to scripting alot, depending on whether we are focusing on the the graphical objects or the code. 
At the top of the script editor choose file>newScript. Save the script as Character.gd.

Now in the Player scene in the scene tree click the new script icon. In the dialog box that pops up next to "Inherits:" click on the folder icon. This lets us choose a custon ancestor object to inherit from. Choose Character.gd.

A kinematic body requires that we define a shape. Create a CollisionShape2D as a child of the Player. With the CollisionShape2D selected move you mouse over to the Inspector tab on the right of the default workspace. The inspector is the place to change the setting of your object. Fo now we are going to set the shape of CollsionShape2D. Select a rectangle from the dropdown.

Create a Camera2D as a child of the player, name it Camera so we can access it by $Camera later. In the inspector set it to Current, by clicking the "On" radio button. The on button is the same as setting the property "= true" in code. Since the camera is a child of the Player, it will go where ever the player goes.

In the Game script create the pitYLevel = 225. We are going to set the Camera.limit_bottom to this variable. To do that we need a way to access the Game variables from the Player. For this we will make a script called ref.gd, which simply has links to variables that we want any part of the program to acesss. In the script editor use File>newScript, this script will simply inherit the defaut Node.  Name it ref.gd. You don't need a ready function for this script, just type in:

    onready var game = "/root/Game"

Save ref.gd.Now go to Project Settings, and in the autoload tab click the folder icon to load ref.gd and click add. Now you can use ref.game anywhere and get acesss to Game.gd varibles.

In the players ready function access the camera and set its limit_bottom:
    
    $Camera.limit_bottom = ref.game.pitYLevel

So later when the player falls down a hole the camera will stop at this limit as expected.
    
    -Player/Character script and inheritance
	-Kinematic Body
	-Collision Shape
	-Camera
	-pitYLevel / Camera.limit_bottom

### 3. Animated Sprite

In the Player scene create an "AnimatedSprite" node. Let's name it sprite to make it easy to access in code. In the Inspector select the Frames property dropdown and choose New SpriteFrames. Now click on the SpriteFrames object that appears. This opens the SpriteFrame tools in the bottom of the screen. On the left of this tools is the Animations list. A default annimation is created for you. You can rename this animation to make your first animation: stand. Drag the stand animations frames from sprites/Megaman (which you should have copied from Start Resources) 

By default the images will be filter upon import. To turn this off, select all the images you wish to fix, then click on the Import tab, located top left along with the scene tab. Scroll down to the Flags section and unclick Filter. Now press the Reimport button. The images will now apear with no filter in all their low bit glory.

Create more animations by clicking the icon of the sheet with a plus sign. Name each one and drag in the appropriate images. 

    stand, walk, jump, fall, 
    shoot_stand, shoot_walk, 
    shoot_jump, shoot_fall, 
    die, hit

Note that for each animation we can set the Speed(FPS) and the Loop. For jump hit and fall we will turn the loop off so the animation sits on the last frame.

	- Create AnimatedSprite
    - Create new SpriteFrame in the Inspector
	- Reimport : filter off in the Import Tab
    - Create animations and drag frame in
  

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


