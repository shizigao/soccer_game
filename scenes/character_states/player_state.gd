extends Node
class_name PlayerState

## 转换节点信号（将与player节点中的switch_state函数关联）
signal state_transition_requested(new_state: Player.State)

var player : Player = null
var animation_player : AnimationPlayer = null

func setup(context_player : Player, context_animation_player: AnimationPlayer):
	player = context_player
	animation_player = context_animation_player
