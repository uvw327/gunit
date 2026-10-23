extends GdUnitTestSuite

const REPORTS_ENABLED_CONFIG := "res://addons/gdUnit4/test/core/resources/project_config/reports_enabled.json"
const REPORTS_DISABLED_CONFIG := "res://addons/gdUnit4/test/core/resources/project_config/reports_disabled.json"


#region reports enabled
func test_shutdown_sends_report_path_as_verbose_message() -> void:
	var writer := FakeReportWriter.new()
	var hook := GdUnitBaseReporterTestSessionHook.new(writer, "FakeReporter", "", Callable())
	var verbose_messages: Array[String] = []
	var messages: Array[String] = []
	var collect_verbose := func(message: String) -> void:
		verbose_messages.append(message)
	var collect_message := func(message: String) -> void:
		messages.append(message)
	GdUnitSignals.instance().gdunit_verbose_message.connect(collect_verbose)
	GdUnitSignals.instance().gdunit_message.connect(collect_message)

	hook.shutdown(GdUnitTestSession.new([], "res://reports", _project_config(REPORTS_ENABLED_CONFIG)))

	GdUnitSignals.instance().gdunit_verbose_message.disconnect(collect_verbose)
	GdUnitSignals.instance().gdunit_message.disconnect(collect_message)

	assert_array(verbose_messages).contains_exactly(["Open HTML Report at: file:///C:/reports/report_1/index.html"])
	assert_array(messages).is_empty()
	assert_int(writer.write_calls).is_equal(1)
#endregion


#region reports disabled
func test_shutdown_skips_report_writing() -> void:
	var writer := FakeReportWriter.new()
	var hook := GdUnitBaseReporterTestSessionHook.new(writer, "FakeReporter", "", Callable())
	var verbose_messages: Array[String] = []
	var messages: Array[String] = []
	var collect_verbose := func(message: String) -> void:
		verbose_messages.append(message)
	var collect_message := func(message: String) -> void:
		messages.append(message)
	GdUnitSignals.instance().gdunit_verbose_message.connect(collect_verbose)
	GdUnitSignals.instance().gdunit_message.connect(collect_message)

	hook.shutdown(GdUnitTestSession.new([], "res://reports", _project_config(REPORTS_DISABLED_CONFIG)))

	GdUnitSignals.instance().gdunit_verbose_message.disconnect(collect_verbose)
	GdUnitSignals.instance().gdunit_message.disconnect(collect_message)

	assert_array(verbose_messages).is_empty()
	assert_array(messages).is_empty()
	assert_int(writer.write_calls).is_equal(0)


func test_startup_does_not_listen_for_test_events() -> void:
	var hook := GdUnitBaseReporterTestSessionHook.new(FakeReportWriter.new(), "FakeReporter", "", Callable())

	hook.startup(GdUnitTestSession.new([], "res://reports", _project_config(REPORTS_DISABLED_CONFIG)))

	assert_that(hook.test_session).is_null()
#endregion


func _project_config(config_file: String) -> GdUnitProjectConfig:
	var config := GdUnitProjectConfig.new()
	config.load_config(config_file)
	return config


class FakeReportWriter extends GdUnitReportWriter:

	var write_calls := 0

	func write(_report_path: String, _report: GdUnitReportSummary) -> String:
		write_calls += 1
		return "C:/reports/report_1/index.html"

	func output_format() -> String:
		return "HTML"
