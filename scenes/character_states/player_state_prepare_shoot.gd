extends PlayerState
class_name PlayerStatePrepareShoot

const DURATION_MAX_BONUS : float = 1000.0
const EASE_REWARD_FACTOR : float = 2.0
## 记录开始射门的时间
var time_start_shoot := Time.get_ticks_msec()
## 每一帧射门的方向向量
var shoot_direction : Vector2 = Vector2.ZERO

func _enter_tree() -> void:
	# 播放动画
	print("play the animation")
	animation_player.play("prep_kick")
	# 停止移动
	player.velocity = Vector2.ZERO
	
func _process(delta: float) -> void:
	# 累加射门方向向量
	shoot_direction += KeyUtils.get_input_vector(player.controlscheme)
	# 如果松开射门按键
	if KeyUtils.is_action_just_released(player.controlscheme, KeyUtils.Action.SHOOT):
		# 计算射门速度
		var duration_press = clamp(Time.get_ticks_msec() - time_start_shoot, 0.0, DURATION_MAX_BONUS)
		var ease_time = duration_press / DURATION_MAX_BONUS
		var bonus : float = ease(ease_time, EASE_REWARD_FACTOR)
		var shoot_power : float = player.power * (1 + bonus)
		# 归一化射门方向向量
		shoot_direction = shoot_direction.normalized()
		print(shoot_power, shoot_direction)
		
		# s
		
