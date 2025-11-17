@abstract
class_name EffectBase
extends Resource

@abstract func _apply(sample: float, time: float, note_len: float) -> float
func apply(sample: float, time: float, note_len: float) -> float:
	return self._apply(sample, time, note_len)
