extends PlayerState
class_name PlayerStateShooting

func _enter_tree() -> void:
	# 播放动画
	animation_player.play("kick")
	animation_player.animation_finished.connect(_on_animation_connect)


func _on_animation_connect(anim_name: StringName):
	# 动画播放结束后射门
	shoot()
	# 状态转换
	if player.controlscheme == Player.ControlScheme.CPU:
		state_transition_requested.emit(Player.State.RECOVERING)
	else:
		state_transition_requested.emit(Player.State.MOVING)
		
func shoot():
	player.ball.shoot(player.state_data.shoot_direction, player.state_data.shoot_power)
