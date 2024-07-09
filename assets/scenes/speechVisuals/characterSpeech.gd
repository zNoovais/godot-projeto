extends Node2D

# ref to character
@onready var character = $Character
@onready var sound = $Character/AudioStreamPlayer2D

# ref to text_box
@onready var text_box = $Speech/text_box
@onready var start = $Speech/text_box/MarginContainer/HBoxContainer/strt
@onready var text = $Speech/text_box/MarginContainer/HBoxContainer/txt
@onready var end = $Speech/text_box/MarginContainer/HBoxContainer/end

# create tween for text animation
@onready var tween = create_tween().bind_node(text)

# ref to speech
@onready var speech00_clss: speech = load("res://assets/scenes/speechVisuals/speech00.tres")
@onready var speech00: Array[String] = speech00_clss.speech00

enum Text_box_state{
	READY,
	READING,
	FINISHED
}

enum Animation_state{
	IDLE,
	TALKING
}

@export var CHAR_READ_RATE = 0.05

var curr_animation = Animation_state.IDLE
var current_text_box_state = Text_box_state.READY
var is_shown = false
var is_talking = false


# Called when the node enters the scene tree for the first time.
func _ready():
	show_text_box()
	#print(speech00)
	#print(msg_queue)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	match current_text_box_state:
		Text_box_state.READY:
			end.text = ""
			if !speech00.is_empty():
				display_text()
		Text_box_state.READING:
			character.play("talking")
			if !sound.playing:
				sound.play()
			if Input.is_action_just_pressed("ui_accept"):
				tween.stop()
				text.visible_ratio = 1.0
				change_curr_state(Text_box_state.FINISHED)
				end.text = "v"
		Text_box_state.FINISHED:
			character.play("idle")
			if Input.is_action_just_pressed("ui_accept"):
				change_curr_state(Text_box_state.READY)
				if speech00.is_empty():
					print("Esconder")
					# Aqui no final deveríamos mudar de cena

# Show text box
func show_text_box():
	text_box.show()
	is_shown = true
	text.text = "*"
	

# hide text box
func hide_text_box():
	text.text = ""
	start.text = ""
	end.text = ""
	text_box.hide()
	is_shown = false
	
func display_text():
	tween = create_tween().bind_node(text)
	var next_text: String = speech00.pop_front()
	var length = next_text.length()
	text.text = next_text
	text.visible_ratio = 0.0
	change_curr_state(Text_box_state.READING)
	tween.tween_property(text, 'visible_characters', length, CHAR_READ_RATE * length)
	await tween.finished
	change_curr_state(Text_box_state.FINISHED)
	end.text = "v"
	
	
# Change current state and print the new state
func change_curr_state(nxt_state):
	current_text_box_state = nxt_state
	match nxt_state:
		Text_box_state.READY:
			print("READY")
		Text_box_state.READING:
			print("READING")
		Text_box_state.FINISHED:
			print("FINISHED")
