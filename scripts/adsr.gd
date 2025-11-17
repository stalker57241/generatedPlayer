class_name ADSR
extends RefCounted

@export_storage
var attack: float = 0.1
@export_storage
var decay: float = 0.6
@export_storage
var sustain: float = 0.3
@export_storage
var release: float = 0.2

@warning_ignore("shadowed_variable")
func _init(
	attack: float = 0.1,
	decay: float = 0.6,
	sustain: float = 0.3,
	release: float = 0.2
):
	self.attack = attack
	self.decay = decay
	self.sustain = sustain
	self.release = release

func _envelope(time: float, note_len: float) -> float:
	if time < attack:
		return time / attack
	elif time < attack + decay:
		return 1.0 - (time - attack) / decay * (1.0 - sustain)
	elif time < note_len:
		return sustain
	else:
		var release_t = time - note_len
		if release_t > release: return 0.0
		
		return sustain * (1.0 - release_t / time)

func apply(sample: float, time: float, note_len: float) -> float:
	return sample * _envelope(time, note_len)
