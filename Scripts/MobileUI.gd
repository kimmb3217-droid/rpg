extends CanvasLayer

func _ready():
	# 터치 기기가 아닌 경우 UI 숨김 (원하면 주석 처리 가능)
	# if not DisplayServer.is_touchscreen_available():
	# 	hide()
	pass

# 모바일 UI 조작은 내부적으로 InputEventAction 등을 발생시키거나
# TouchScreenButton을 통해 ui_left, ui_right, ui_accept와 연동할 수 있습니다.
