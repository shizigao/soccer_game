extends Node
class_name BallState

signal state_transition_requested(new_state : Ball.State)

var ball : Ball = null
var player_detection_area: Area2D

func setup(context_ball : Ball, context_player_detection_area) -> void:
	ball = context_ball
	player_detection_area = context_player_detection_area
	
	
