extends Node
class_name BallStateFactory

func get_fresh_state(state: Ball.State):
	if state == Ball.State.CARRIED:
		return BallStateCarreid.new()
	elif state == Ball.State.FREEFORM:
		return BallStateFreeform.new()
	elif state == Ball.State.SHOT:
		return BallStateShot.new()
	else:
		return null
