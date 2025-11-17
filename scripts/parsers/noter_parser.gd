class_name NoteParser
extends Parser


@abstract
class NoterAction:
	pass

class AppendAction extends NoterAction:
	pass

class AppendNoteAction extends AppendAction:
	var note: Note
	func _init(n: Note):
		self.note = n

class AppendWaitAction extends AppendAction:
	var length: int = 1
	func _init(_len: int = 1):
		self.length = 1

class LoadInstrument extends NoterAction:
	var instrument_id: int = -1
	func _init(iid: int = -1):
		self.instrument_id = iid

@abstract
class PreloadAction extends NoterAction: pass
class PreloadInstrument extends PreloadAction:
	var slot_id: int
	var instrument_name: String
	func _init(_slot_id: int, _instrument_name: String):
		self.slot_id = _slot_id
		self.instrument_name = _instrument_name

class WriteTrack extends NoterAction:
	var track_name: String
	func _init(name: String):
		self.track_name = name

class JumpAction extends NoterAction:
	var next_name: String
	func _init(name: String):
		self.next_name = name

class ReturnAction extends NoterAction:
	pass

func parseline(array: Array) -> Array[NoterAction]:
	match array:
		[".instrument", var slot_id, var instrument_name]:
			return [
				PreloadInstrument.new(slot_id, instrument_name)
			]
		["TRACK", var elem] when str(elem).trim_suffix(":").is_valid_ascii_identifier() and elem.ends_with(":"):
			return [WriteTrack.new(elem)]
		["INST", var instrument_id]:
			print("INST: %s" % [instrument_id])
			return [LoadInstrument.new(instrument_id)]
		["NOTE", var notename]:
			print("NOTE: %s (last instrument)" % [notename])
			return [AppendNoteAction.new(Note.parse(notename))]
		["NOTE", var notename, var instrument]:
			print("NOTE: %s %s" % [notename, instrument])
			return [
				LoadInstrument.new(int(instrument)),
				AppendNoteAction.new(Note.parse(notename))
			]
		
		["WAIT", var count]:
			print("WAIT: %s" % [count])
			return [AppendWaitAction.new(int(count))]
		
		["WAIT",]:
			print("WAIT: 1")
			return [AppendWaitAction.new()]
		["NEXT", var trackname]:
			return [JumpAction.new(trackname)]
		
		["RET",]:
			return [ReturnAction.new()]
	return []

func _parse(code: String):
	var noteblocks: Array = []
	
	print(lines)
	for line in lines:
		parseline(line)
	return []
