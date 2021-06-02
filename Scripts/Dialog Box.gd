extends ColorRect

export var dialogpath = ""
export(float) var textspeed = 0.1

var dialog

var phrasenum = 0
var finished = false

func _ready():
	$Timer.wait_time = textspeed
	dialog = getDialog()
	assert(dialog, "Dialog not found")
	nextPhrase()

func _process(_delta):
	if finished:
		$Talking.stop()
	$Indicator.visible = finished
	$Indicator/AnimationPlayer.play("Dialog Box")
	if Input.is_action_just_pressed("ui_next"):
		if finished:
			nextPhrase()
		else:
			$Text.visible_characters = len($Text.text)

func getDialog() -> Array:
	var f = File.new()
	assert(f.file_exists(dialogpath), "File Path does not exist.")

	f.open(dialogpath, File.READ)
	var json = f.get_as_text()
	
	var output = parse_json(json)
	
	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return []

func nextPhrase() -> void:
	if phrasenum >= len(dialog):
		queue_free()
		get_node("/root/World").dialogbox_num -= 1
		return
	
	finished = false
	
	$Name.bbcode_text = dialog[phrasenum]["Name"]
	$Text.bbcode_text = dialog[phrasenum]["Text"]
	
	$Text.visible_characters = 0
	
	var f = File.new()
	var img = "Text/" + dialog[phrasenum]["Name"] + ".png"
	if f.file_exists(img):
		$Potrait.texture = load(img)
	else:
		$Potrait.texture = null
	
	while $Text.visible_characters < len($Text.text):
		$Text.visible_characters += 1
		$Talking.play()
		$Timer.start()
		yield($Timer, "timeout")
	
	finished = true
	phrasenum += 1
	return
