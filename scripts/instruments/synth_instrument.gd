class_name SynthInstrument
extends InstrumentBase

enum Waveform { SINE, SQUARE, SAW, TRIANGLE, NOISE }
@export var waveform: Waveform = Waveform.SINE

static func _get_wave(wf: Waveform, t: float, freq: float) -> float:
	match wf:
		Waveform.SINE: return sin(t * TAU * freq)
		Waveform.SQUARE: return sign(_get_wave(Waveform.SINE, t, freq))
		Waveform.SAW: return 2.0 * (t * freq - floor(0.5 + t * freq))
		Waveform.TRIANGLE: return abs(_get_wave(Waveform.SAW, t, freq)) * 2.0 - 1.0
		Waveform.NOISE: return randf_range(-1.0, 1.0)
		_: return 0.0

func _gen_sample(note: Note, time: float, _note_len: float) -> float:
	return _get_wave(self.waveform, time, note.get_freq())
