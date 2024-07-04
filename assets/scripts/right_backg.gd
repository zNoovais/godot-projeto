extends Node2D

@onready var bus_low = $BusLow
@onready var bus_low_2 = $BusLow2
@onready var bus_mid = $BusMid
@onready var bus_full = $BusFull

var bus_delay
var busactive = 0

func busStart():
	bus_delay = randi_range (5,20)
	print(bus_delay)
	busactive = 1
	bus_low.visible = true
	await get_tree().create_timer(bus_delay).timeout
	bus_low.visible = false
	bus_low_2.visible = true
	await get_tree().create_timer(bus_delay).timeout
	bus_low_2.visible = false
	bus_mid.visible = true
	await get_tree().create_timer(bus_delay).timeout
	bus_mid.visible = false
	bus_full.visible = true
	await get_tree().create_timer(bus_delay).timeout
	bus_full.visible = false
	busactive = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	busStart()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
