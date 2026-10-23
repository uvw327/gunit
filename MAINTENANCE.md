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
- [x] Remove the `dotnet build` step from `addons/gdUnit4/runtest.sh`
- [x] Remove the dedicated C# documentation collection and top-level C# references
- [x] Run `gdstyle check` and the full GDScript test suite

Verification:

- `gdstyle check --max-warnings 0 addons/gdUnit4/`: 375 files, no issues.
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
| B | A + rename `addons/gdUnit4` and all `res://addons/gdUnit4/...` paths | Medium risk, requires full test run |
| C | B + rename all `GdUnit*` classes, signals, and file names | High risk, breaks upstream merges and generated mock code |

Planned steps for scope B:

- [ ] Choose the new addon name
- [ ] Rename the addon folder and update every `res://addons/gdUnit4/...` reference
- [ ] Update `plugin.cfg` (`name`, `description`, `author`)
- [ ] Update `project.godot` plugin path and the plugin icon references
- [ ] Update the release workflow archive name and `.github/docs` references
- [ ] Update the test suite template default content
- [ ] Run `gdstyle check` and the full GDScript test suite

## Phase 3 - Documentation Cleanup

- [ ] Remove the remaining `{% tab ... C# %}` examples from the documentation
- [ ] Replace upstream screenshots and links that no longer match the fork
- [ ] Update the documentation site configuration (title, URL, navigation)
- [ ] Publish or drop the Jekyll site; the fork currently has no automated deployment

## Follow-up work

- Keep `addons/gdUnit4/test/` running with a non-.NET Godot binary; C# tests are removed in Phase 1.
- Update this file when a phase is completed and keep the status list accurate.
