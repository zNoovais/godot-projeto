extends Node2D

@onready var bus = $RightBackg/Bus
@onready var right_backg = $RightBackg
@onready var timer = $RightBackg/Timer

# variaveis:

var bus_delay
var busactive = 0
var elapse = 0

#constantes:

# para as posições 0 1 2 3
const scales = [Vector2(0.045,0.061), Vector2(0.102,0.135),Vector2(0.204,0.252),Vector2(0.43,0.492)]
const positions = [Vector2(57.084,-39.78), Vector2(62.337,-24.115),Vector2(-11.305,-9.091),Vector2(-155,13.949)]
const points = [0,10,40,100]

const frequency = 5



func busStart():
	print("COMEÇOU")
	elapse = 0
	busactive = 1
	var i = 0
	var fst = 0
	bus_delay = randi_range(5,10)
	bus.flip_h = false
	while(i != 4):
		if(fst != 0):
			bus.flip_h = true
		bus.position = positions[i]
		bus.scale = scales[i]
		bus.visible = true
		print(bus_delay)
		await get_tree().create_timer(bus_delay).timeout # delay do bus 
		bus_delay *= 0.60
		i += 1
	bus.visible = false
	busactive = 0	
	
func _ready():
	var score = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(not busactive):
		elapse += delta
	if(elapse > frequency):
		if(randi() % 2):
			busStart()
		else:
			print("nao começou")
			elapse = 0

