@abstract
class_name InstrumentBase
extends Resource

@export var volume: float = 0.2
@export var effects: Array[EffectBase] = []
var adsr: ADSR

@abstract
func _gen_sample(note: Note, time: float, note_len: float) -> float

func gen_sample(note: Note, time: float, note_len: float) -> float:
	var out: float = adsr.apply(_gen_sample(note, time, note_len) * volume, time, note_len)

	# Применяем цепочку эффектов (ADSR, Delay, …)
	for effect in effects:
		out = effect.apply(out, time, note_len)
	return out
