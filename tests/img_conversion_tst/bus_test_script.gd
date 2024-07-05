extends Node2D

var import1 = load("res://assets/scripts/img_bit_converter.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	var img = Image.new()
	img.load("res://assets/sprites/bus_sprites/Bus.png")
	#var dif_pallete = import1.convert_to_16bit_palette(img)
	#var img_texture = ImageTexture.create_from_image(dif_pallete)
	var img_texture = ImageTexture.create_from_image(img)
	$Bus.texture = img_texture
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
