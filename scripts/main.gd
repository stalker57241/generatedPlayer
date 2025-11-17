@tool
extends EditorScript


# Called when the script is executed (using File -> Run in Script Editor).
func _run():
	var parser = NoteParser.new()
	
	parser.parse_raw("
.entry _start
# Точка входа
_start:
	INST 0 \"synth.ins\"
# 	НОТА До-4 инструмент
	NOTE C4   0
	WAIT
	WAIT 4
	NOTE C4   1
	")
