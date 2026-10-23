class_name GdUnitTestSuiteTemplate
extends RefCounted

const TEMPLATE_ID_GD = 1000
const SUPPORTED_TAGS_GD = """
	GdScript Tags are replaced when the test-suite is created.

	# The class name of the test-suite, formed from the source script.
	${suite_class_name}
	# is used to build the test suite class name
		class_name ${suite_class_name}
		extends GdUnitTestSuite


	# The class name in pascal case, formed from the source script.
	${source_class}
		# can be used to create the class e.g. for source 'MyClass'
		var my_test_class := ${source_class}.new()
		# will be result in
		var my_test_class := MyClass.new()

	# The class as variable name in snake case, formed from the source script.
	${source_var}
		# Can be used to build the variable name e.g. for source 'MyClass'
		var ${source_var} := ${source_class}.new()
		# will be result in
		var my_class := MyClass.new()

	# The full resource path from which the file was created.
	${source_resource_path}
		# Can be used to load the script in your test
		var my_script := load(${source_resource_path})
		# will be result in
		var my_script := load("res://folder/my_class.gd")
"""
const TAG_TEST_SUITE_CLASS = "${suite_class_name}"
const TAG_SOURCE_CLASS_NAME = "${source_class}"
const TAG_SOURCE_CLASS_VARNAME = "${source_var}"
const TAG_SOURCE_RESOURCE_PATH = "${source_resource_path}"


static func default_gd_template() -> String:
	return GdUnitTestSuiteDefaultTemplate.DEFAULT_TEMP_TS_GD.dedent().trim_prefix("\n")


static func build_template(source_path: String) -> String:
	var clazz_name: String = GdObjects.to_pascal_case(GdObjects.extract_class_name(source_path).value_as_string())
	var template: String = GdUnitSettings.get_setting(GdUnitSettings.TEMPLATE_TS_GD, default_gd_template())

	return template\
		.replace(TAG_TEST_SUITE_CLASS, clazz_name + "Test")\
		.replace(TAG_SOURCE_RESOURCE_PATH, source_path)\
		.replace(TAG_SOURCE_CLASS_NAME, clazz_name)\
		.replace(TAG_SOURCE_CLASS_VARNAME, GdObjects.to_snake_case(clazz_name))


static func default_template(template_id: int) -> String:
	if template_id != TEMPLATE_ID_GD:
		push_error("Invalid template '%d' id! Cant load testsuite template" % template_id)
		return ""
	return default_gd_template()


static func load_template(template_id: int) -> String:
	if template_id != TEMPLATE_ID_GD:
		push_error("Invalid template '%d' id! Cant load testsuite template" % template_id)
		return ""
	return GdUnitSettings.get_setting(GdUnitSettings.TEMPLATE_TS_GD, default_gd_template())


static func save_template(template_id: int, template: String) -> void:
	if template_id != TEMPLATE_ID_GD:
		push_error("Invalid template '%d' id! Cant load testsuite template" % template_id)
		return
	GdUnitSettings.save_property(GdUnitSettings.TEMPLATE_TS_GD, template.dedent().trim_prefix("\n"))


static func reset_to_default(template_id: int) -> void:
	if template_id != TEMPLATE_ID_GD:
		push_error("Invalid template '%d' id! Cant load testsuite template" % template_id)
		return
	GdUnitSettings.save_property(GdUnitSettings.TEMPLATE_TS_GD, default_gd_template())


static func load_tags(template_id: int) -> String:
	if template_id != TEMPLATE_ID_GD:
		push_error("Invalid template '%d' id! Cant load testsuite template" % template_id)
		return "Error checked loading tags"
	return SUPPORTED_TAGS_GD
