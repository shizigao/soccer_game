extends Node
class_name BallState

signal state_transition_requested(new_state : Ball.State)
## 重力加速度
const GRAVITY : float = 10
## 摩擦力系数
const FRICTION_AIR : float = 35
const FRICTION_GROUND : float = 120
## 球落地后的弹跳系数
const BOUNCE_RATE : float = 0.8

var ball : Ball = null
var player_detection_area: Area2D

func setup(context_ball : Ball, context_player_detection_area) -> void:
	ball = context_ball
	player_detection_area = context_player_detection_area
	
	
func set_ball_animation_from_velocity():
	if ball.velocity == Vector2.ZERO:
		ball.animation_player.play("idle")
	elif ball.velocity.x < 0:
		ball.ball_sprite.flip_h = true
		ball.animation_player.play("roll")
	else:
		ball.ball_sprite.flip_h = false
		ball.animation_player.play("roll")

func process_friction(delta : float):
	var friction = FRICTION_AIR if ball.height > 0 else FRICTION_GROUND
	ball.velocity = ball.velocity.move_toward(Vector2.ZERO, friction * delta)
		
func process_gravity(delta : float):
	if ball.height > 0 or ball.height_velocity > 0:
		ball.height_velocity -= GRAVITY * delta
		ball.height += ball.height_velocity
		# 球落地，弹跳，速度减慢
		if ball.height < 0:
			ball.height = 0
			ball.height_velocity *= -BOUNCE_RATE
			ball.velocity *= BOUNCE_RATE
