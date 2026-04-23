extends Node
class_name PlayerStateFactory

func get_fresh_state(state : Player.State) -> PlayerState:
	if state == Player.State.MOVING:
		return PlayerStateMoving.new()
	elif state == Player.State.TACKLING:
		return PlayerStateTackling.new()
	elif state == Player.State.RECOVERING:
		return PlayerStateRecovering.new()
	elif state == Player.State.PREPARE_SHOOT:
		return PlayerStatePrepareShoot.new()
	elif state == Player.State.SHOOTING:
		return PlayerStateShooting.new()
	elif state == Player.State.PASSING:
		return PlayerStatePassing.new()
		
	else :
		printerr("player_state_factory can't return a non-existent PlayerState")
		return null
