extends Node2D

const IDLE_DUR = 1.0

export var move_to = Vector2.UP * 100
export var speed = 2.0

onready var platform = $Platform
onready var move = $Move

var smooth_transition = Vector2.ZERO

func _ready():
	_move_tween()
	
func _physics_process(delta):
	platform.position = platform.position.linear_interpolate(smooth_transition, 0.05)    

func _move_tween():
	var dur = move_to.length() / float(speed)
	get_tree().Tween.interpolate_property(self, "smooth_transition", Vector2.ZERO, move_to, dur, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, IDLE_DUR)
	get_tree().Tween.interpolate_property(self, "smooth_transition", Vector2.ZERO, dur, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, dur + IDLE_DUR * 2)
	get_tree().Tween.start()
