
# add this to your script with "const json_handling = preload("res://scripts/json_handling.gd")" at
# the top of the file.

static func load_json(path: String) -> Variant:
	if not FileAccess.file_exists(path):
		print("can't find this file")
		return null
		
	var jsonfile = FileAccess.open(path, FileAccess.READ)
	var json_string = jsonfile.get_as_text()
	
	# Creates the helper class to interact with JSON.
	var json = JSON.new()

	# Check if there is any error while parsing the JSON string, skip in case of failure.
	var parse_result = json.parse(json_string)
	if not parse_result == OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
		return null
		
	
	var json_result = json.parse_string(json_string)
	
	return json_result
