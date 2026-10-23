# Fork Maintenance Plan

This repository is a personal fork of [gdUnit4](https://github.com/MikeSchulze/gdUnit4), a Godot 4 unit testing
framework released under the MIT license. The fork is renamed and maintained independently, GDScript only.

## Licensing and Attribution

The upstream project is licensed under the MIT license (`LICENSE`, Copyright (c) 2023-2026 Mike Schulze).
The MIT license permits modification, renaming, and redistribution as long as the original copyright notice and
permission notice are retained.

When renaming or rebranding the fork:

- Keep the original copyright line in `LICENSE`; append your own copyright line instead of replacing it.
- Keep the upstream attribution in `README.md` and link back to the upstream repository.
- Do not imply that the fork is endorsed by, or represents, the upstream project or its author.
- MIT does not grant trademark rights. A public fork should use a distinct name and not reuse upstream branding.

## Phase 1 - Remove C# Support

The fork only uses GDScript. Removing the C# integration shrinks the code base and reduces the surface for the
later rename.

Status: **completed** (2026-10-23)

- [x] Remove `.cs` sources and the `src/dotnet` bridge
- [x] Remove C# test suites, test fixtures, and C#-conditional tests
- [x] Remove C# branches from discovery, execution, scanner, resource loader, and template code
- [x] Remove the C# test suite template from settings and UI
- [x] Remove `gdUnit4.csproj`, `gdUnit4.sln`, and `global.json`
- [x] Remove the `.NET`-specific root configuration (`.runsettings`, `Directory.Build.props`, `nuget.config`, `stylecop.*`)
- [x] Drop the `C#` feature and the `[dotnet]` section from `project.godot`
- [x] Remove the `dotnet build` step from `addons/gunit/runtest.sh`
- [x] Remove the dedicated C# documentation collection and top-level C# references
- [x] Run `gdstyle check` and the full GDScript test suite

Verification:

- `gdstyle check --max-warnings 0 addons/gunit/`: 375 files, no issues.
- Full GDScript suite on Godot 4.7.2: 1767 test cases, 0 errors. The only failures are in
  `GdMarkDownReaderTest.test_process_external_image_save_as_png`, which downloads external images and fails in the
  offline test environment; they are unrelated to this change.
- Remaining C# content is limited to `{% tab ... C# %}` examples and C#-specific prose in the documentation,
  scheduled for Phase 3.

## Phase 2 - Rename the Addon

The rename is split into three scopes. Scope B is the intended target: it removes the old name from everything a
user sees, while keeping upstream-derived internal identifiers, which also documents the fork's origin.

| Scope | Change | Impact |
| ----- | ------ | ------ |
| A | Display name only (`plugin.cfg`, `README`, release archive name, docs title) | Low risk, old name remains in paths and code |
| B | A + rename `addons/gdUnit4` to `addons/gunit` and update all paths | Medium risk, requires full test run |
| C | B + rename all `GdUnit*` classes, signals, and file names | High risk, breaks upstream merges and generated mock code |

Status: **completed** (2026-10-23)

Steps completed:

- [x] Choose the new addon name: `gunit`
- [x] Rename `addons/gdUnit4` to `addons/gunit` and update every path reference
- [x] Update `plugin.cfg` (`name`, `description`, `author`)
- [x] Update `project.godot` project name, plugin path, and the settings section (`[gdunit4]` → `[gunit]`)
- [x] Rename the editor settings category `GdUnitSettings.MAIN_CATEGORY` to `gunit` so Project Settings no longer shows the old name
- [x] Update the release workflow archive name and `.github` references
- [x] Update user-visible display strings (console title, settings, command palette, version label)
- [x] Update the HTML report templates and reporter fixtures
- [x] Regenerate the binary `simple_scene.scn` fixture with the new resource paths
- [x] Point documentation download/feedback links and `llms.txt` at the fork repository
- [x] Remove the dead C# analyzer configuration from `.editorconfig`
- [x] Run `gdstyle check` and the full GDScript test suite

Verification:

- `gdstyle check --max-warnings 0 addons/gunit/`: 375 files, no issues.
- Full GDScript suite on Godot 4.7.2: 1767 test cases, 0 errors, 1 intentional flaky test, 22 skipped. The only
  failures (2-3 depending on network timeouts) are the known offline-only
  `GdMarkDownReaderTest.test_process_external_image_save_as_png` assertions.
- Deliberately kept (scope C was not included): internal `GdUnit*` class names and file names
  (e.g. `GdUnit4Version`), the `GdUnit4Inspector` editor meta key, the `GdUnit4_*` memory-observer node tags,
  and upstream issue/documentation URLs in code comments and test fixtures (attribution and traceability).
- Attribution that is kept on purpose: the upstream copyright line in `LICENSE` (plus a fork copyright line),
  the fork notice in `README.md` and `MAINTENANCE.md`, and the `(fork of gdUnit4)` note in `plugin.cfg`.

## Phase 3 - Documentation Cleanup

- [ ] Remove the remaining `{% tab ... C# %}` examples from the documentation
- [ ] Replace the remaining product-name prose in the docs (`GdUnit inspector`, `GdUnitHtmlTestReporter`, ...) with `gunit`
- [ ] Update the CI documentation: `_faq/ci.md` and the README still advertise the upstream `gdUnit4-action`, which
      installs upstream releases and is therefore wrong for fork users; document a fork-compatible CI setup
- [ ] Replace upstream screenshots and links that no longer match the fork
- [ ] Update the documentation site navigation and version paths
- [ ] Publish or drop the Jekyll site; the fork currently has no automated deployment

## Follow-up work

- Keep `addons/gunit/test/` running with a non-.NET Godot binary; C# tests are removed in Phase 1.
- Update this file when a phase is completed and keep the status list accurate.
