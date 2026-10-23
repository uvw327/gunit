extends GdUnitTestSuite


func test_from() -> void:
	var test := GdUnitTestCase.from(
		"res://addons/gunit/test/ui/parts/GdUnitInspectorTreeMainPanelTest.gd",
		"res://addons/gunit/test/ui/parts/GdUnitInspectorTreeMainPanelTest.gd",
		0,
		"test_foo")

	assert_str(test.test_name).is_equal("test_foo")
	assert_str(test.suite_name).is_equal("GdUnitInspectorTreeMainPanelTest")
	assert_str(test.fully_qualified_name).is_equal("addons.gunit.test.ui.parts.GdUnitInspectorTreeMainPanelTest.test_foo")
