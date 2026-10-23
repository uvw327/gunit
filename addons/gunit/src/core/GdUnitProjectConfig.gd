class_name GdUnitProjectConfig
extends RefCounted
##
## Loads the optional project configuration file [code].gunit.json[/code] from the Godot project root.[br]
## [br]
## [i]The configuration file is optional and is not created automatically. If it is missing, every option
## is disabled, which means no test report files are written and only the test results are printed.[/i][br]
## [br]
## The file must contain a JSON object, for example:[br]
## [codeblock]
## {
##     "reports": true,
##     "verbose": false
## }
## [/codeblock]
## [br]
## [b][u]Supported options[/u][/b][br]
## - [code]reports[/code]: when set to [code]true[/code], the HTML and JUnit XML reports are written to the
##   report directory after each test session. Defaults to [code]false[/code], so no report files are generated.[br]
## - [code]verbose[/code]: when set to [code]true[/code], additional informational messages are printed to the console,
##   like the session hook installation, the report locations or the runner setup. Defaults to [code]false[/code],
##   so only the test results and the summary are printed.

## The location of the project configuration file, relative to the Godot project root.
const CONFIG_FILE := "res://.gunit.json"
## The option to enable the report file generation.
const REPORTS := "reports"
## The option to enable the verbose console output.
const VERBOSE := "verbose"

var _config: Dictionary = {}


## Loads the project configuration from the Godot project root.[br]
## [br]
## A missing configuration file is not an error, it simply results in a configuration with all options disabled.
## An invalid configuration file is reported as a warning and is also handled as all options disabled.
static func load_default() -> GdUnitProjectConfig:
	var config := GdUnitProjectConfig.new()
	var result := config.load_config()
	if result.is_error():
		push_warning(result.error_message())
	return config


## Loads the project configuration from the given [param path].[br]
## [br]
## Returns a success result when the file is missing (all options disabled), or an error result when the file
## cannot be read or does not contain a valid JSON object.
func load_config(path: String = CONFIG_FILE) -> GdUnitResult:
	_config = {}
	if not FileAccess.file_exists(path):
		return GdUnitResult.success()
	var file := FileAccess.open(path, FileAccess.READ)
	if file == null:
		return GdUnitResult.error("Can't read the project configuration '%s'! Error: %s" % [path, error_string(FileAccess.get_open_error())])
	var content := file.get_as_text().lstrip("\ufeff")
	if content.strip_edges().is_empty():
		return GdUnitResult.success()

	var json := JSON.new()
	if json.parse(content) != OK:
		return GdUnitResult.error("The project configuration '%s' is invalid! %s at line %d." % [path, json.get_error_message(), json.get_error_line()])
	var data: Variant = json.get_data()
	if not data is Dictionary:
		return GdUnitResult.error("The project configuration '%s' is invalid! Expected a JSON object." % path)
	_config = data
	return GdUnitResult.success(path)


## Returns whether the report files are enabled by the project configuration.[br]
## [br]
## Reports are only generated when the configuration file exists and contains [code]"reports": true[/code].
func reports_enabled() -> bool:
	return _is_bool_option_enabled(REPORTS)


## Returns whether the verbose console output is enabled by the project configuration.[br]
## [br]
## Verbose output is only enabled when the configuration file exists and contains [code]"verbose": true[/code].
func is_verbose_enabled() -> bool:
	return _is_bool_option_enabled(VERBOSE)


func _is_bool_option_enabled(option: String) -> bool:
	var value: Variant = _config.get(option, false)
	return value is bool and value
