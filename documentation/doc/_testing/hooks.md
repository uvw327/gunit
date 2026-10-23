---
layout: default
title: Hooks
nav_order: 4
---

# gunit Hooks

## Overview

gunit provides multiple levels of hooks to control test execution and manage test resources. Understanding the hierarchy and execution order of these hooks is essential for writing efficient and maintainable tests.

### Hook Types and Hierarchy

gunit offers three distinct levels of hooks, each serving a specific purpose:

| Hooks            | Scope | Frequency | Primary Use Case |
|------------------|-------|-----------|------------------|
| **Session**  | Entire test session | Once per test run | External services, global resources, custom reporting |
| **TestSuite** | Single test suite | Once per suite | Suite-level shared resources, expensive setup |
| **TestCase** | Individual tests | Before/after each test | Test isolation, fresh state per test |

**Key Differences:**

- **Session Hooks** are optional and configured globally in [gunit settings]({{site.baseurl}}/first_steps/settings/#hooks-settings). They wrap the entire test execution.
- **TestSuite Hooks** (`before`/`after`) run once for all tests in a suite.
- **TestCase Hooks** (`before_test`/`after_test`) run for each individual test, ensuring test isolation.

For information about Session Hooks, see [Testing with Hooks]({{site.baseurl}}/advanced_testing/hooks/#testing-with-hooks).

### Test Execution Graph Overview

![Execution Graph]({{site.baseurl}}/assets/images/hooks/execution-graph-gdscript.svg){:.centered}

> **ProjectSettings isolation is automatic.** gunit snapshots all `ProjectSettings` before each suite and each test case, and restores any changed values afterwards. Tests can modify `ProjectSettings` freely in any hook or test body — no manual save/restore is needed. See [Manually Saving and Restoring ProjectSettings](#6-manually-saving-and-restoring-projectsettings) and [FAQ: Modifying ProjectSettings during Tests]({{site.baseurl}}/faq/solutions/#modifying-projectsettings-during-tests).

## When to Use Each Hook

Choosing the right hook level is crucial for test performance and maintainability:

### Use `before()` / `[Before]` when

- Setting up expensive resources that can be shared across all tests (read-only)
- Creating database schemas or test data that won't be modified
- Initializing external services or connections
- Loading large test fixtures or configuration files

### Use `before_test()` / `[BeforeTest]` when

- Each test needs a fresh, isolated state
- Creating mutable test data that tests will modify
- Setting up mock objects or stubs specific to a test
- Ensuring complete test independence

### Common Anti-patterns to Avoid

- ❌ Using `before()` for mutable state that tests modify (causes test interdependence)
- ❌ Using `before_test()` for expensive operations repeated unnecessarily
- ❌ Forgetting to clean up resources in corresponding `after` hooks

---

## TestSuite Hooks

gunit provide the following suite hooks that allow you to control the test environment.
gunit allows you to use asserts within these stages, and any errors that occur will be reported.

| Stage           |Description|
|-----------------| ---|
| before          | executed only once at the start of the TestSuite run        |
| after           | executed only once at the end of the TestSuite run          |

## Hook *before*

This function is executed once at the beginning of the TestSuite and is used to set up any resources or data that will be required by all of the test cases in the suite. For example, if you need to create a database connection or initialize a global configuration object, you would do so in this function.

**func before()**<br>
Use this function inside your TestSuite to define a pre-hook and prepare your TestSuite data.

```gdscript
class_name GdUnitExampleTest
extends GdUnitTestSuite

var _test_data :Node
var _config :Dictionary

# create some test data here
func before():
    _test_data = Node.new()
    _config = load_test_configuration()
```

## Hook *after*

This function is executed once at the end of the TestSuite and is used to clean up any resources or data that was created or modified during the test run. For example, if you need to close a database connection or delete temporary files, you would do so in this function.

**func after():**<br>
Use this function inside your TestSuite to define a shutdown hook and release your TestSuite data.

```gdscript
class_name GdUnitExampleTest
extends GdUnitTestSuite

var _test_data :Node
var _db_connection

func after():
    # Clean up resources created in before()
    if _test_data:
        _test_data.free()
    if _db_connection:
        _db_connection.close()
```

---

## TestCase Hooks

gunit provide the following test hooks that allow you to control the test environment.
gunit allows you to use asserts within these stages, and any errors that occur will be reported.

| Stage           |Description|
|-----------------| ---|
| before_test     | executed before each test is started                        |
| after_test      | executed after each test has finished                       |

## Hook *before_test*

This function is executed before each test case and is used to set up any resources or data that are required by the test case. For example, if you need to create a temporary file or initialize a class instance, you would do so in this function.

**func before_test():**<br>
Use this function inside your TestSuite to define a pre hook to initialize your TestCase data.

```gdscript
class_name GdUnitExampleTest
extends GdUnitTestSuite

var _test_instance :Node

func before_test():
    # Each test gets a fresh instance
    _test_instance = auto_free(Node.new())
    _test_instance.name = "TestNode"
```

## Hook *after_test*

This function is executed after each test case and is used to clean up any resources or data that were created or modified during the test case. For example, if you need to delete a temporary file or close a network connection, you would do so in this function.

**func after_test():**<br>
Use this function inside your TestSuite to define a test cleanup hook to release your TestCase data if needed.

```gdscript
class_name GdUnitExampleTest
extends GdUnitTestSuite

var _temp_file_path :String

func after_test():
    # Clean up test-specific resources
    if _temp_file_path and FileAccess.file_exists(_temp_file_path):
        DirAccess.remove_absolute(_temp_file_path)
    # Reset any modified global state
    reset_test_environment()
```

---

## Common Pitfalls and Solutions

### 1. Orphan Nodes

**Problem:** Forgetting to free nodes creates orphan warnings.  
**Solution:** Always use `auto_free()` or manually free in cleanup hooks.

### 2. Test Interdependence

**Problem:** Tests fail when run individually but pass when run together.  
**Solution:** Use `before_test()` instead of `before()` for mutable state.

### 3. Resource Leaks

**Problem:** File handles, network connections, or timers not cleaned up.  
**Solution:** Always implement corresponding cleanup in `after` hooks:

```gdscript
func before_test():
    _file = FileAccess.open("test.txt", FileAccess.WRITE)
    _timer = auto_free(Timer.new())
    
func after_test():
    if _file:
        _file.close()
    # Timer is auto-freed
```

### 4. Signal Connection Leaks

**Problem:** Signals remain connected after tests.  
**Solution:** Disconnect signals in cleanup or use `auto_free()` for the connected objects.

### 5. Incorrect Hook Choice

**Problem:** Using `before()` for data that each test modifies.  
**Solution:** Follow the "When to Use Each Hook" guide above.

### 6. Manually Saving and Restoring ProjectSettings

**Problem:** Tests that change `ProjectSettings` (e.g. warning modes, feature flags) leak those changes to later tests, causing unpredictable failures.  
**Solution:** gunit automatically snapshots all `ProjectSettings` before each suite and each test, and restores any changed values afterwards. There is no need to save the previous value and restore it in an `after` hook:

```gdscript
# unnecessary — the framework restores ProjectSettings automatically
func before():
    _saved = ProjectSettings.get_setting("some/setting")
    ProjectSettings.set_setting("some/setting", true)

func after():
    ProjectSettings.set_setting("some/setting", _saved)
```

```gdscript
# correct — just set what the tests need
func before():
    ProjectSettings.set_setting("some/setting", true)
```

---

## See Also

- [Testing with Hooks]({{site.baseurl}}/advanced_testing/hooks/#testing-with-hooks) - Learn about Session-level hooks
- [Settings - Hooks Configuration]({{site.baseurl}}/first_steps/settings/#hooks-settings) - Configure session hooks
