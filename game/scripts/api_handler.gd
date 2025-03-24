extends Node

const url := "https://backend.project-persona.com"


func start_conversation(authID:String, message:String, instruction:String, converID:String):
	var header = [
		"User-Agent: Pirulo/1.0 (Godot)",
		"Accept: */*"
	]
	
	var body = {
		"authID": authID,
		"message": message,
		"instructions": instruction,
		"conversationID": converID
	}
	
	#return ["conversationID", "response"]
	
	var json_body = JSON.stringify(body)
	var response = await post_request("/start_conversation", header, json_body)
	var json_response = JSON.parse_string(response)
	
	if response != "":
		return [json_response["conversationID"], json_response["message"]]
		
	return ["", "Server Error"]

	

func continue_conversation(authID:String, message:String, converID:String):
	var header = [
		"User-Agent: Pirulo/1.0 (Godot)",
		"Accept: */*"
	]
	
	var body = {
		"authID": authID,
		"message": message,
		"conversationID": converID
	}
	
	#return "response"
	
	var json_body = JSON.stringify(body)
	var response = await post_request("/continue_conversation", header, json_body)
	var json_response = JSON.parse_string(response)
	
	if response != "":
		return json_response["message"]
		
	return "Server Error"
	
func end_conversation(authID:String) -> bool:
	var header = [
		"User-Agent: Pirulo/1.0 (Godot)",
		"Accept: */*"
	]
	
	var body = {
		"authID": authID
	}
	
	#return true
	
	var json_body = JSON.stringify(body)
	var response = await post_request("/end_conversation", header, json_body)
	var json_response = JSON.parse_string(response)
	
	if response != "":
		return true
		
	return false
	
func sign_in(username:String, password:String) -> bool:
	
	# Some headers
	var header = [
		"User-Agent: Pirulo/1.0 (Godot)",
		"Accept: */*"
	]
	
	var body = {
		"username": username,
		"password": password
	}
	
	var json_body = JSON.stringify(body)

	var response = await post_request("/login", header, json_body)
	
	var json_response = JSON.parse_string(response)
	
	var auth_id = null
	
	if response != "":
		auth_id = json_response["authID"]
		ServerVariables.auth_id = auth_id
		ServerVariables.username = username
		return true
		
	return false
	
func final_score(sentiment_score:int, knowledge_score:int, sales_score:int) -> bool:
		
	# Some headers
	var header = [
		"User-Agent: Pirulo/1.0 (Godot)",
		"Accept: */*"
	]
	
	var body = {
		"authID" : ServerVariables.auth_id,
		"sentiment_points" : sentiment_score,
		"sales_points" : sales_score,
		"knowledge_points" : knowledge_score
	}
	
	var json_body = JSON.stringify(body)

	var response = await post_request("/modify_points", header, json_body)
	
	if response != "":
		return true
		
	return false
	
	
func send_session_score():
	pass
	
func ping():
	var header = []

	var response = await get_request("/ping", header)
	return response
	
func get_request(extension:String, header:PackedStringArray) -> String:
	var err = 0
	var http = HTTPClient.new() # Create the Client.
	
	err = http.connect_to_host(url, 443) # Connect to host/port.
	assert(err == OK) # Make sure connection is OK.
	
	while http.get_status() == HTTPClient.STATUS_CONNECTING or http.get_status() == HTTPClient.STATUS_RESOLVING:
		http.poll()
		print("Connecting...")
		print(http.get_status())
		await get_tree().process_frame

	assert(http.get_status() == HTTPClient.STATUS_CONNECTED)
	
	err = http.request(HTTPClient.METHOD_GET, extension, header) # Request a page from the site (this one was chunked..)
	assert(err == OK) # Make sure all is OK.

	while http.get_status() == HTTPClient.STATUS_REQUESTING:
		# Keep polling for as long as the request is being processed.
		http.poll()
		print("Requesting...")
		print(http.get_status())
		await get_tree().process_frame

	assert(http.get_status() == HTTPClient.STATUS_BODY or http.get_status() == HTTPClient.STATUS_CONNECTED) # Make sure request finished well.

	print("response? ", http.has_response()) # Site might not have a response.

	if http.has_response():
		# If there is a response...

		var new_header = http.get_response_headers_as_dictionary() # Get response headers.
		print("code: ", http.get_response_code()) # Show response code.
		print("**headers:\\n", new_header) # Show headers.

		# Getting the HTTP Body

		if http.is_response_chunked():
			# Does it use chunks?
			print("Response is Chunked!")
		else:
			# Or just plain Content-Length
			var bl = http.get_response_body_length()
			print("Response Length: ", bl)

		# This method works for both anyway

		var rb = PackedByteArray() # Array that will hold the data.

		while http.get_status() == HTTPClient.STATUS_BODY:
			# While there is body left to be read
			http.poll()
			# Get a chunk.
			var chunk = http.read_response_body_chunk()
			if chunk.size() == 0:
				await get_tree().process_frame
			else:
				rb = rb + chunk # Append to read buffer.
		# Done!

		print("bytes got: ", rb.size())
		var text = rb.get_string_from_ascii()
		print("Text: ", text)
		return text
	return "Error"
	http.quit()
	
func post_request(extension:String, header:PackedStringArray, body:String) -> String:
	var err = 0
	var http = HTTPClient.new() # Create the Client.

	err = http.connect_to_host(url, 443) # Connect to host/port.
	assert(err == OK) # Make sure connection is OK.

	# Wait until resolved and connected.
	while http.get_status() == HTTPClient.STATUS_CONNECTING or http.get_status() == HTTPClient.STATUS_RESOLVING:
		http.poll()
		print("Connecting...")
		print(http.get_status())
		await get_tree().process_frame

	assert(http.get_status() == HTTPClient.STATUS_CONNECTED) # Check if the connection was made successfully.
	
	err = http.request(HTTPClient.METHOD_POST, extension, header, body) # Request a page from the site (this one was chunked..)
	assert(err == OK) # Make sure all is OK.

	while http.get_status() == HTTPClient.STATUS_REQUESTING:
		# Keep polling for as long as the request is being processed.
		http.poll()
		print("Requesting...")
		print(http.get_status())
		await get_tree().process_frame

	assert(http.get_status() == HTTPClient.STATUS_BODY or http.get_status() == HTTPClient.STATUS_CONNECTED) # Make sure request finished well.

	print("response? ", http.has_response()) # Site might not have a response.

	if http.has_response():
		# If there is a response...

		var new_header = http.get_response_headers_as_dictionary() # Get response headers.
		print("code: ", http.get_response_code()) # Show response code.
		if http.get_response_code() != 200:
			return ""
		print("**headers:\\n", new_header) # Show headers.

		# Getting the HTTP Body

		if http.is_response_chunked():
			# Does it use chunks?
			print("Response is Chunked!")
		else:
			# Or just plain Content-Length
			var bl = http.get_response_body_length()
			print("Response Length: ", bl)

		# This method works for both anyway

		var rb = PackedByteArray() # Array that will hold the data.

		while http.get_status() == HTTPClient.STATUS_BODY:
			# While there is body left to be read
			http.poll()
			# Get a chunk.
			var chunk = http.read_response_body_chunk()
			if chunk.size() == 0:
				await get_tree().process_frame
			else:
				rb = rb + chunk # Append to read buffer.
		# Done!
		print("bytes got: ", rb.size())
		var text = rb.get_string_from_ascii()
		print("Text: ", text)
		
		return text
	return "Error"
	http.quit()
	
