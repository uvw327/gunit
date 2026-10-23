@tool
extends Node

signal request_completed(response: HttpResponse)

var _http_request := HTTPRequest.new()


func _ready() -> void:
	add_child(_http_request)
	@warning_ignore("return_value_discarded")
	_http_request.request_completed.connect(_on_request_completed)


func _notification(what: int) -> void:
	if what == NOTIFICATION_PREDELETE:
		if is_instance_valid(_http_request):
			_http_request.queue_free()


func request_zip_package(url: String, file: String) -> HttpResponse:
	_http_request.set_download_file(file)
	var error := _http_request.request(url)
	if error != OK:
		var message := "request_zip_package failed: %d" % error
		return HttpResponse.new(error, message.to_utf8_buffer())
	return await self.request_completed


func _on_request_completed(_result: int, response_http_status: int, _headers: PackedStringArray, body: PackedByteArray) -> void:
	if _http_request.get_http_client_status() != HTTPClient.STATUS_DISCONNECTED:
		_http_request.set_download_file("")
	request_completed.emit(HttpResponse.new(response_http_status, body))


class HttpResponse:
	var _http_status: int
	var _body: PackedByteArray

	func _init(http_status: int, body: PackedByteArray) -> void:
		_http_status = http_status
		_body = body

	func status() -> int:
		return _http_status

	func response() -> Variant:
		if _http_status != 200:
			return _body.get_string_from_utf8()

		var test_json_conv := JSON.new()
		@warning_ignore("return_value_discarded")
		var error := test_json_conv.parse(_body.get_string_from_utf8())
		if error != OK:
			return "HttpResponse: %s Error: %s" % [error_string(error), _body.get_string_from_utf8()]
		return test_json_conv.get_data()

	func get_body() -> PackedByteArray:
		return _body
