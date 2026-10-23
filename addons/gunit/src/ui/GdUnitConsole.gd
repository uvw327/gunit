@tool
class_name GdUnitConsole
extends Control

var _test_reporter: GdUnitConsoleTestReporter
## Optional project configuration to control the console output.[br]
## [br]
## By default the configuration is loaded from [code].gunit.json[/code] on every message, so changes are applied
## immediately without restarting the editor.
var project_config: GdUnitProjectConfig

@onready var output: RichTextLabel = $VBoxContainer/Console/TextEdit


func _ready() -> void:
	GdUnitFonts.init_fonts(output)
	output.add_theme_constant_override("line_separation", 3)
	GdUnitSignals.instance().gdunit_event.connect(_on_gdunit_event)
	GdUnitSignals.instance().gdunit_message.connect(_on_gdunit_message)
	GdUnitSignals.instance().gdunit_verbose_message.connect(_on_gdunit_verbose_message)
	GdUnitSignals.instance().gdunit_client_connected.connect(_on_gdunit_client_connected)
	GdUnitSignals.instance().gdunit_client_disconnected.connect(_on_gdunit_client_disconnected)
	_test_reporter = GdUnitConsoleTestReporter.new(GdUnitRichTextMessageWriter.new(output))


func _notification(what: int) -> void:
	if what == NOTIFICATION_PREDELETE:
		var instance := GdUnitSignals.instance()
		if instance.gdunit_event.is_connected(_on_gdunit_event):
			instance.gdunit_event.disconnect(_on_gdunit_event)
		if instance.gdunit_message.is_connected(_on_gdunit_event):
			instance.gdunit_message.disconnect(_on_gdunit_message)
		if instance.gdunit_verbose_message.is_connected(_on_gdunit_verbose_message):
			instance.gdunit_verbose_message.disconnect(_on_gdunit_verbose_message)
		if instance.gdunit_client_connected.is_connected(_on_gdunit_event):
			instance.gdunit_client_connected.disconnect(_on_gdunit_client_connected)
		if instance.gdunit_client_disconnected.is_connected(_on_gdunit_event):
			instance.gdunit_client_disconnected.disconnect(_on_gdunit_client_disconnected)


func _on_gdunit_event(event: GdUnitEvent) -> void:
	match event.type():
		GdUnitEvent.SESSION_START:
			_test_reporter.test_session = GdUnitTestSession.new(GdUnitTestDiscoverGuard.instance().get_discovered_tests(), "")
		GdUnitEvent.SESSION_CLOSE:
			_test_reporter.test_session = null


func _on_gdunit_client_connected(client_id: int) -> void:
	_test_reporter.clear()
	if _is_verbose_enabled():
		_test_reporter.println_message("GdUnit Test Client connected with id: %d" % client_id, GdUnitEditorColorTheme.folder_color)


func _on_gdunit_client_disconnected(client_id: int) -> void:
	if _is_verbose_enabled():
		_test_reporter.println_message("GdUnit Test Client disconnected with id: %d" % client_id, GdUnitEditorColorTheme.folder_color)


func _on_gdunit_message(message: String) -> void:
	_test_reporter.println_message(message, GdUnitEditorColorTheme.folder_color)


func _on_gdunit_verbose_message(message: String) -> void:
	if _is_verbose_enabled():
		_on_gdunit_message(message)


func _is_verbose_enabled() -> bool:
	var config := project_config if project_config != null else GdUnitProjectConfig.load_default()
	return config.is_verbose_enabled()
