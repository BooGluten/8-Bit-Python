extends Node2D

var mail_scene = preload("res://mail.tscn")
var mail2 = preload("res://MAil2.tscn")
var mail3 = preload("res://Mail3.tscn")
var final_mail = mail3.instance()
var mail = 0

func _ready():
	pass
	#if mail_scene.connect("mail_sent", self, "on_state_changed"):
	#	print("l")
	#	if mail2.connect("mail_sent", self, "on_state_changed"):
	#		print("h")
		
