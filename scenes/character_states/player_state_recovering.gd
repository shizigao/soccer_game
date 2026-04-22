extends PlayerState
class_name PlayerStateRecovering

## 恢复的持续时间（单位：毫秒）
const DURATION_RECOVER := 300
## 开始恢复的时间
var time_start_tackle := Time.get_ticks_msec()

func _enter_tree() -> void:
	# 角色速度变为0
	player.velocity = Vector2.ZERO
	# 播放恢复动画
	animation_player.play("recover")
	# 开始记录时间
	time_start_tackle = Time.get_ticks_msec()
	

func _process(delta: float) -> void:
	# 持续DURATION_TACKLE后改变状态
	if Time.get_ticks_msec() - time_start_tackle >= DURATION_RECOVER:
		state_transition_requested.emit(Player.State.MOVING)
