extends Area2D

var bullet_scene = preload("res://Bullet.tscn")

func _ready():
	pass # Replace with function body.

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		body.HasGottenGun()
		self.hide()
		

