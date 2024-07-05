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
const scales = [Vector2(0.018,0.021), Vector2(0.029,0.036),Vector2(0.077,0.09),Vector2(0.206,0.23)]
const positions = [Vector2(50,-40), Vector2(77,-27.4),Vector2(7,-10.96),Vector2(-126.52,2.705)]

const frequency = 5



func busStart():
	print("COMEÇOU")
	elapse = 0
	busactive = 1
	var i = 0
	var fst = 0
	bus_delay = randi_range(10,20)
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
	pass


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

