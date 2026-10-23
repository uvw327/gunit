class_name GdUnitProjectConfigTest
extends GdUnitTestSuite

const REPORTS_ENABLED_CONFIG := "res://addons/gdUnit4/test/core/resources/project_config/reports_enabled.json"
const REPORTS_DISABLED_CONFIG := "res://addons/gdUnit4/test/core/resources/project_config/reports_disabled.json"


#region reports option
func test_reports_enabled_by_config() -> void:
	var config := GdUnitProjectConfig.new()

	assert_result(config.load_config(REPORTS_ENABLED_CONFIG)).is_success()
	assert_bool(config.reports_enabled()).is_true()


func test_reports_disabled_by_config() -> void:
	var config := GdUnitProjectConfig.new()

	assert_result(config.load_config(REPORTS_DISABLED_CONFIG)).is_success()
	assert_bool(config.reports_enabled()).is_false()


func test_reports_disabled_on_missing_config_file() -> void:
	var config := GdUnitProjectConfig.new()

	assert_result(config.load_config("res://.gunit_not_existing.json")).is_success()
	assert_bool(config.reports_enabled()).is_false()


func test_reports_disabled_when_option_is_missing() -> void:
	assert_bool(_load_config("{\"some_option\": true}").reports_enabled()).is_false()


func test_reports_disabled_when_option_is_not_a_boolean() -> void:
	assert_bool(_load_config("{\"reports\": \"true\"}").reports_enabled()).is_false()


func test_reports_disabled_on_empty_config_file() -> void:
	assert_bool(_load_config("").reports_enabled()).is_false()


func test_reports_enabled_on_config_file_with_bom() -> void:
	assert_bool(_load_config("\ufeff{\"reports\": true}").reports_enabled()).is_true()
#endregion


#region verbose option
func test_verbose_enabled_by_config() -> void:
	assert_bool(_load_config("{\"verbose\": true}").is_verbose_enabled()).is_true()


func test_verbose_disabled_by_default() -> void:
	assert_bool(GdUnitProjectConfig.new().is_verbose_enabled()).is_false()


func test_verbose_disabled_when_option_is_missing() -> void:
	assert_bool(_load_config("{\"reports\": true}").is_verbose_enabled()).is_false()


func test_verbose_disabled_when_option_is_not_a_boolean() -> void:
	assert_bool(_load_config("{\"verbose\": 1}").is_verbose_enabled()).is_false()
#endregion


#region invalid config
func test_load_config_fails_on_invalid_json() -> void:
	var config := GdUnitProjectConfig.new()
	var result := config.load_config(_create_config_file("{\"reports\": true"))

	assert_result(result).is_error()
	assert_str(result.error_message()).contains("The project configuration '%s' is invalid!" % _config_file_path())
	assert_bool(config.reports_enabled()).is_false()


func test_load_config_fails_on_non_object_json() -> void:
	var config := GdUnitProjectConfig.new()
	var result := config.load_config(_create_config_file("[true]"))

	assert_result(result).is_error()
	assert_str(result.error_message()).contains("Expected a JSON object.")
	assert_bool(config.reports_enabled()).is_false()
#endregion


func _load_config(content: String) -> GdUnitProjectConfig:
	var config := GdUnitProjectConfig.new()
	config.load_config(_create_config_file(content))
	return config


func _config_file_path() -> String:
	return create_temp_dir("project_config") + "/.gunit.json"


func _create_config_file(content: String) -> String:
	var file_path := _config_file_path()
	var file := FileAccess.open(file_path, FileAccess.WRITE)
	file.store_string(content)
	file.close()
	return file_path
