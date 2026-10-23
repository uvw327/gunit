class_name GdUnitTestSessionTest
extends GdUnitTestSuite

const REPORTS_ENABLED_CONFIG := "res://addons/gdUnit4/test/core/resources/project_config/reports_enabled.json"
const REPORTS_DISABLED_CONFIG := "res://addons/gdUnit4/test/core/resources/project_config/reports_disabled.json"


#region find_test_by_id
func test_find_test_by_id() -> void:
	var test_cases := _test_cases()
	var session := GdUnitTestSession.new(test_cases, "res://reports")

	assert_that(session.find_test_by_id(test_cases[0].guid)).is_same(test_cases[0])
	assert_that(session.find_test_by_id(test_cases[1].guid)).is_same(test_cases[1])


func test_find_test_by_id_with_equal_guid() -> void:
	var test_cases := _test_cases()
	var session := GdUnitTestSession.new(test_cases, "res://reports")

	assert_that(session.find_test_by_id(GdUnitGUID.new(str(test_cases[1].guid)))).is_same(test_cases[1])


func test_find_test_by_id_not_found() -> void:
	var session := GdUnitTestSession.new(_test_cases(), "res://reports")

	assert_object(session.find_test_by_id(GdUnitGUID.new())).is_null()
#endregion


#region test_count
func test_test_count() -> void:
	assert_int(GdUnitTestSession.new(_test_cases(), "res://reports").test_count()).is_equal(2)


func test_test_count_without_tests() -> void:
	assert_int(GdUnitTestSession.new([], "res://reports").test_count()).is_equal(0)
#endregion


#region documented examples
# The following tests verify the examples of the migration guide page
# documentation/doc/_first_steps/migration-v7.md


func test_doc_migration_test_count_example() -> void:
	var session := GdUnitTestSession.new(_test_cases(), "res://reports")

	var test_count := session.test_count()

	assert_int(test_count).is_equal(2)
#endregion


#region reports enabled
func test_is_reports_enabled_by_project_config() -> void:
	var session := GdUnitTestSession.new([], "res://reports", _project_config(REPORTS_ENABLED_CONFIG))

	assert_bool(session.is_reports_enabled()).is_true()


func test_is_reports_disabled_by_project_config() -> void:
	var session := GdUnitTestSession.new([], "res://reports", _project_config(REPORTS_DISABLED_CONFIG))

	assert_bool(session.is_reports_enabled()).is_false()


func test_is_reports_disabled_when_project_config_is_not_set() -> void:
	var session := GdUnitTestSession.new([], "res://reports", GdUnitProjectConfig.new())

	assert_bool(session.is_reports_enabled()).is_false()
#endregion


#region verbose messages
func test_send_verbose_message() -> void:
	var session := GdUnitTestSession.new([], "res://reports")
	var verbose_messages: Array[String] = []
	var messages: Array[String] = []
	var collect_verbose := func(message: String) -> void:
		verbose_messages.append(message)
	var collect_message := func(message: String) -> void:
		messages.append(message)
	GdUnitSignals.instance().gdunit_verbose_message.connect(collect_verbose)
	GdUnitSignals.instance().gdunit_message.connect(collect_message)

	session.send_verbose_message("verbose message")

	GdUnitSignals.instance().gdunit_verbose_message.disconnect(collect_verbose)
	GdUnitSignals.instance().gdunit_message.disconnect(collect_message)

	assert_array(verbose_messages).contains_exactly(["verbose message"])
	assert_array(messages).is_empty()


func test_send_message_is_not_a_verbose_message() -> void:
	var session := GdUnitTestSession.new([], "res://reports")
	var verbose_messages: Array[String] = []
	var messages: Array[String] = []
	var collect_verbose := func(message: String) -> void:
		verbose_messages.append(message)
	var collect_message := func(message: String) -> void:
		messages.append(message)
	GdUnitSignals.instance().gdunit_verbose_message.connect(collect_verbose)
	GdUnitSignals.instance().gdunit_message.connect(collect_message)

	session.send_message("message")

	GdUnitSignals.instance().gdunit_verbose_message.disconnect(collect_verbose)
	GdUnitSignals.instance().gdunit_message.disconnect(collect_message)

	assert_array(messages).contains_exactly(["message"])
	assert_array(verbose_messages).is_empty()
#endregion


func _project_config(config_file: String) -> GdUnitProjectConfig:
	var config := GdUnitProjectConfig.new()
	config.load_config(config_file)
	return config


func _test_cases() -> Array[GdUnitTestCase]:
	var test_cases: Array[GdUnitTestCase] = [
		GdUnitTestCase.from("res://test/example_suite.gd", "res://test/example_suite.gd", 10, "test_a"),
		GdUnitTestCase.from("res://test/example_suite.gd", "res://test/example_suite.gd", 14, "test_b"),
	]
	return test_cases
