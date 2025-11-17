@abstract
class_name Parser
extends Object


static func readfile(filename: String) -> String:
	var file: FileAccess = FileAccess.open(filename, FileAccess.READ)
	if file == null:
		push_error("Failed to read file: " + error_string(FileAccess.get_open_error()))
		return ""
	var text: String = file.get_as_text(true)
	
	file.close()
	return text

@abstract func _parse(code: String)

func parse(filename: String):
	return _parse(readfile(filename))

func parse_raw(code: String):
	return _parse(code)
