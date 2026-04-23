extends BallState
class_name BallStateShot
# 缩放精灵，营造速度感
const SHOOT_SPRITE_SCALE : float = 0.8
# 球的飞行高度
const SHOOT_HEIGHT : float = 5.0
# 球飞行的持续时间
var duration_time : float = 1000
var time_start_shooting := Time.get_ticks_msec()

func _enter_tree() -> void:
	# 携带者为空
	ball.carrier = null

	ball.ball_sprite.scale.y = SHOOT_SPRITE_SCALE
	# 播放动画
	set_ball_animation_from_velocity()
	
	ball.height = SHOOT_HEIGHT
	
func _process(delta: float) -> void:
	# 处理摩擦力
	process_friction(delta)
	ball.move_and_collide(ball.velocity * delta)
	
	if Time.get_ticks_msec() - time_start_shooting >= duration_time:
		state_transition_requested.emit(Ball.State.FREEFORM)
	else:
		ball.move_and_collide(ball.velocity * delta)
	
func _exit_tree() -> void:
	ball.ball_sprite.scale.y = 1
