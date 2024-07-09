extends Node2D

@onready var character = $Character/Barradas
@onready var text_box = $Dialogue_box/text_box

@onready var speech00_clss: speech00 = load("res://tests/character_speech_test/speech00.tres")
@onready var speech00: Array[String] = speech00_clss.speech00


# Importar texto desejado
func _ready():
	print(curr_state)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func change_animation_state(active):
	if active:
		character.play("talking")
	else:
		character.play("idle")
