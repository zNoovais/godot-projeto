extends CanvasLayer

var CHAR_READ_RATE = 0.05

@onready var text_box = $text_box
@onready var strt = $text_box/MarginContainer/HBoxContainer/strt
@onready var txt = $text_box/MarginContainer/HBoxContainer/txt
@onready var end = $text_box/MarginContainer/HBoxContainer/end
@onready var tween = create_tween().bind_node(self)

enum State{
	READY,
	READING,
	FINISHED
}

var cur_state = State.READY
var is_shown = false

func _ready():
	#START 
	print("READY")
	show_text_box()
	add_text("Este é um teste para ver se o diálogo funciona.")
	
func _process(_delta):
	match cur_state:
		State.READY:
			emit_signal("ready", cur_state)
		State.READING:
			if Input.is_action_just_pressed("ui_accept"):
				tween.stop()
				txt.visible_ratio = 1.0
				change_state(State.FINISHED)
				emit_signal("ready", cur_state)
		State.FINISHED:
			if Input.is_action_just_pressed("ui_accept") and is_shown:
				change_state(State.READY)
				emit_signal("ready", cur_state)
	
func hide_text_box():
	strt.text = ""
	txt.text = ""
	end.text = ""
	text_box.hide()
	
func show_text_box():
	text_box.show()
	is_shown = true
	strt.text = "*"
	
func add_text(text):
	var length = text.length()
	txt.text = text
	change_state(State.READING)
	tween.tween_property(txt, 'visible_characters', length, CHAR_READ_RATE * length)
	await tween.finished
	change_state(State.FINISHED)
	
func change_state(nxt):
	cur_state = nxt
	match cur_state:
		State.READY:
			print("READY")
		State.READING:
			print("READING")
		State.FINISHED:
			print("FINISHED")
	
