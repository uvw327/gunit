class_name GdUnitConsoleTest
extends GdUnitTestSuite

const VERBOSE_ENABLED_CONFIG := "res://addons/gunit/test/core/resources/project_config/verbose_enabled.json"
const VERBOSE_DISABLED_CONFIG := "res://addons/gunit/test/core/resources/project_config/verbose_disabled.json"

var _console: GdUnitConsole


func before_test() -> void:
	_console = load("res://addons/gunit/src/ui/GdUnitConsole.tscn").instantiate()
	add_child(_console)


func after_test() -> void:
	remove_child(_console)
	_console.free()


#region client connection messages
func test_client_connected_message_is_hidden_when_verbose_disabled() -> void:
	_console.project_config = _project_config(VERBOSE_DISABLED_CONFIG)

	GdUnitSignals.instance().gdunit_client_connected.emit(42)

	assert_str(_console.output.get_parsed_text()).not_contains("GdUnit Test Client connected")


func test_client_connected_message_is_printed_when_verbose_enabled() -> void:
	_console.project_config = _project_config(VERBOSE_ENABLED_CONFIG)

	GdUnitSignals.instance().gdunit_client_connected.emit(42)

	assert_str(_console.output.get_parsed_text()).contains("GdUnit Test Client connected with id: 42")


func test_client_disconnected_message_is_hidden_when_verbose_disabled() -> void:
	_console.project_config = _project_config(VERBOSE_DISABLED_CONFIG)

	GdUnitSignals.instance().gdunit_client_disconnected.emit(42)

	assert_str(_console.output.get_parsed_text()).not_contains("GdUnit Test Client disconnected")


func test_client_disconnected_message_is_printed_when_verbose_enabled() -> void:
	_console.project_config = _project_config(VERBOSE_ENABLED_CONFIG)

	GdUnitSignals.instance().gdunit_client_disconnected.emit(42)

	assert_str(_console.output.get_parsed_text()).contains("GdUnit Test Client disconnected with id: 42")
#endregion


#region verbose messages
func test_verbose_message_is_hidden_when_verbose_disabled() -> void:
	_console.project_config = _project_config(VERBOSE_DISABLED_CONFIG)

	GdUnitSignals.instance().gdunit_verbose_message.emit("a verbose message")

	assert_str(_console.output.get_parsed_text()).not_contains("a verbose message")


func test_verbose_message_is_printed_when_verbose_enabled() -> void:
	_console.project_config = _project_config(VERBOSE_ENABLED_CONFIG)

	GdUnitSignals.instance().gdunit_verbose_message.emit("a verbose message")

	assert_str(_console.output.get_parsed_text()).contains("a verbose message")
#endregion


#region normal messages
func test_message_is_printed_when_verbose_disabled() -> void:
	_console.project_config = _project_config(VERBOSE_DISABLED_CONFIG)

	GdUnitSignals.instance().gdunit_message.emit("a normal message")

	assert_str(_console.output.get_parsed_text()).contains("a normal message")
#endregion


func _project_config(config_file: String) -> GdUnitProjectConfig:
	var config := GdUnitProjectConfig.new()
	config.load_config(config_file)
	return config
