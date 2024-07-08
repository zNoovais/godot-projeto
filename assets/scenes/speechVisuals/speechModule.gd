extends CanvasLayer

var CHAR_READ_RATE = 0.05

@onready var text_box = $text_box
@onready var strt = $text_box/MarginContainer/HBoxContainer/strt
@onready var txt = $text_box/MarginContainer/HBoxContainer/txt
@onready var end = $text_box/MarginContainer/HBoxContainer/end
@onready var tween = create_tween().bind_node(self)

func _ready():
	show_text_box()
	add_text("Mano adoro mesmo mesmo mesmo isto")
	add_text("Ceci comete comete comete cheiras a merda")
	add_text("Estou a brincar e somos todos amigos e fofinhos e amigos")

func hide_text_box():
	strt.text = ""
	txt.text = ""
	end.text = ""
	text_box.hide()
	
func show_text_box():
	text_box.show()
	strt.text = "*"
	
func add_text(text):
	var length = text.length()
	txt.text = text
	tween.tween_property(txt, 'visible_characters', length, CHAR_READ_RATE * length)
	await tween.finished
	
