extends PlayerState
class_name PlayerStateTackling

## 铲球的持续时间（单位：毫秒）
const DURATION_TACKLE := 200
## 摩擦力
const GROUND_FRICTION := 250
## 开始铲球的时间
var time_finish_tackle := Time.get_ticks_msec()


func _enter_tree() -> void:
	# 播放铲球动画
	animation_player.play("tackle")
	

func _process(delta: float) -> void:
	# 先根据摩擦力逐渐减慢速度
	if player.velocity != Vector2.ZERO:
		player.velocity = player.velocity.move_toward(Vector2.ZERO, delta * GROUND_FRICTION)
		if player.velocity == Vector2.ZERO:
			# 此时已停止运动，记录时间
			time_finish_tackle = Time.get_ticks_msec()
			
	# 持续DURATION_TACKLE后改变状态
	elif Time.get_ticks_msec() - time_finish_tackle >= DURATION_TACKLE:
		state_transition_requested.emit(Player.State.RECOVERING)
