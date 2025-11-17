class_name Note
extends Object

enum SemitoneId { NONE = 0, DIESE = 1, BEMOLE = -1 }
enum Id {C = 0, D = 2, E = 4, F = 5, G = 7, A = 9, B = 11 }

@export var octave_id:		int
@export var id:				Id
@export var semitone_id:	SemitoneId
@export var duration: 		float = 0.5 # Секунды

@warning_ignore("shadowed_variable")
func _init(id: Id, semitone: SemitoneId = SemitoneId.NONE, octave_id: int = 0):
	self.id = id
	self.semitone_id = semitone
	self.octave_id = octave_id

static func parse(txt: String) -> Note:
	var note: int = "CDEFGAB".find(txt.substr(0, 1))
	var semitone: int = 0
	var octave: int = 0
	if txt.substr(1, 1) in "#b":
		if txt.substr(1, 1) == "#":
			semitone = SemitoneId.DIESE
		elif txt.substr(1, 1) == "b":
			semitone = SemitoneId.BEMOLE
		elif txt.substr(1, 1) in "0123456789":
			semitone = 0
		elif txt.substr(1, 1) == "":
			semitone = 0
			octave = 0
	var real_note = {
		"C": 0,
		"D": 2,
		"E": 4,
		"F": 5,
		"G": 7,
		"A": 9,
		"B": 11,
	}["CDEFGAB".substr(note, 1)]
	if semitone == 0:
		if txt.substr(1, 1) != "":
			if txt.substr(1, 1) in "0123456789":
				octave = int(txt.substr(1, 1))
				print("octave: " + str(octave))
			else:
				octave = 0
	else:
		if txt.substr(2, 1) != "":
			if txt.substr(2, 1) in "0123456789":
				octave = int(txt.substr(2, 1))
			else:
				octave = 0
	return Note.new(real_note, semitone, octave)


func get_duration() -> float:
	return self.duration

func get_midi_number() -> int:
	return (octave_id + 1) * 12 + int(self.id) + int(self.semitone_id)

func get_freq() -> float:
	return 440.0 * pow(2.0, (get_midi_number() - 69) / 12.0)

func _to_string() -> String:
	var name = {
		Id.C: "C", Id.D: "D", Id.E: "E", Id.F: "F",
		Id.G: "G", Id.A: "A", Id.B: "B"
	}[id]
	var acc = "#" if semitone_id == SemitoneId.DIESE else ("b" if semitone_id == SemitoneId.BEMOLE else "")
	return "%s%s%d" % [name, acc, octave_id]
