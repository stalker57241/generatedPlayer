class_name ParseTools
extends Object

static var singleline_comment_prefix: String = "#"

static func strip_esc(x: String) -> String:
	return x.strip_escapes()

static func filter_comments(x: String) -> bool:
	return not x.begins_with(singleline_comment_prefix)

static func filter_null(x) -> bool:
	return x != null

static func filter_empty(x) -> bool:
	return !x.is_empty()

static func split_words(x: String) -> Array:
	return Array(x.split(" ")).filter(filter_empty).map(strip_esc)

static func _static_init():
	pass

## Returns [Array][[Array][[String]]], like
## [codeblock]
##		[["MOV", "ax", "bx"], ["RET"]]
## [/codeblock]
static func asm_parse(code: String) -> Array:
	var lines: Array = Array(code.split("\n", false))
	print(lines)
	return lines \
		.map(strip_esc) \
		.filter(filter_comments) \
		.filter(filter_null) \
		.map(split_words) \
		.filter(filter_null).filter(filter_empty)
