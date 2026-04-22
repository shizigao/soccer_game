extends BallState
class_name BallStateCarreid
const offset_from_player := Vector2(8, 4)

# 运球频率和强度（正弦震荡）
const dribble_frequency : float = 10
const dribble_intensity : float = 3
var dribble_time : float = 0

func _enter_tree() -> void:
	assert(ball.carrier!= null)
	
func _process(delta: float) -> void:
	var vx : float = 0.0
	var vy : float = 0.0
	# 根据球的速度，选择是否播放动画
	if ball.carrier.velocity != Vector2.ZERO:
		dribble_time += delta
		# 正弦函数形式的震荡
		vx = cos(dribble_frequency * dribble_time) * dribble_intensity
		vy = cos(dribble_frequency * dribble_time) * dribble_intensity
		# 根据玩家向左还是向右，选择是否翻转足球精灵
		if ball.carrier.velocity.x < 0:
			ball.ball_sprite.flip_h = true
		else:
			ball.ball_sprite.flip_h = false

		ball.animation_player.play("roll")
	else:
		dribble_time = 0
		ball.animation_player.play("idle")
		
	# 让球的位置始终追随玩家（同时伴随正弦函数形式的震荡）ds
	ball.position = ball.carrier.position + Vector2(ball.carrier.heading.x * offset_from_player.x + vx, offset_from_player.y)
