#!/usr/bin/env bash
#
# release.sh - create and push a release tag.
#
# Usage:
#   ./release.sh                 # auto-increment the patch version of the latest tag
#   ./release.sh v0.2.1          # use an explicit tag
#   ./release.sh --dry-run       # only print the tag that would be created
#
# Pushing a "v*" tag triggers .github/workflows/release-addon.yml, which packages
# addons/gunit into gunit-<tag>.zip (without *.uid files) and publishes it as a
# GitHub Release.

set -euo pipefail

usage() {
	cat <<'EOF'
Usage: release.sh [--dry-run] [tag]

Create an annotated git tag and push it to origin.
Pushing a "v*" tag triggers .github/workflows/release-addon.yml.

Arguments:
  tag          Explicit tag, must match v<major>.<minor>.<patch> (e.g. v0.2.1).
               If omitted, the patch version of the latest tag is incremented
               (v0.2.0 -> v0.2.1, v0.2.1 -> v0.2.2, ...).

Options:
  -n, --dry-run  Print the tag that would be created and exit without tagging.
  -h, --help     Show this help.
EOF
}

DRY_RUN=false
TAG=""

while [[ $# -gt 0 ]]; do
	case "$1" in
		-n | --dry-run) DRY_RUN=true ;;
		-h | --help)
			usage
			exit 0
			;;
		-*)
			echo "error: unknown option '$1'" >&2
			usage >&2
			exit 1
			;;
		*)
			if [[ -n "$TAG" ]]; then
				echo "error: unexpected extra argument '$1'" >&2
				usage >&2
				exit 1
			fi
			TAG="$1"
			;;
	esac
	shift
done

# --- resolve the tag ----------------------------------------------------------

# Newest tag by version order (v0.10.0 > v0.2.0), regardless of branch.
latest_tag="$(git tag --sort=-v:refname | head -n 1 || true)"

if [[ -z "$TAG" ]]; then
	if [[ -z "$latest_tag" ]]; then
		TAG="v0.0.1"
	elif [[ "$latest_tag" =~ ^v([0-9]+)\.([0-9]+)\.([0-9]+)$ ]]; then
		TAG="v${BASH_REMATCH[1]}.${BASH_REMATCH[2]}.$((BASH_REMATCH[3] + 1))"
	else
		echo "error: latest tag '$latest_tag' is not in v<major>.<minor>.<patch> format;" \
			"pass an explicit tag (see --help)" >&2
		exit 1
	fi
fi

if [[ ! "$TAG" =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
	echo "error: tag '$TAG' must look like v1.2.3" >&2
	exit 1
fi

# Warn when an explicit tag is older than the latest one (e.g. re-tagging).
if [[ -n "$latest_tag" && "$TAG" != "$latest_tag" ]]; then
	oldest="$(printf '%s\n%s\n' "$latest_tag" "$TAG" | sort -V | head -n 1)"
	if [[ "$oldest" == "$TAG" ]]; then
		echo "warning: '$TAG' is older than the latest tag '$latest_tag'" >&2
	fi
fi

echo "latest tag: ${latest_tag:-<none>}"
echo "new tag:    $TAG"

if $DRY_RUN; then
	echo "(dry run, nothing was created)"
	exit 0
fi

# --- preflight checks ---------------------------------------------------------

if git rev-parse -q --verify "refs/tags/$TAG" >/dev/null 2>&1; then
	echo "error: tag '$TAG' already exists" >&2
	exit 1
fi

if [[ -n "$(git status --porcelain)" ]]; then
	echo "error: working tree is dirty; commit or stash your changes first" >&2
	exit 1
fi

# --- tag and push --------------------------------------------------------------

git tag -a "$TAG" -m "Release $TAG"
git push origin "$TAG"

echo
echo "Pushed $TAG."
echo "The release workflow builds gunit-$TAG.zip and publishes it at:"
echo "  https://github.com/uvw327/gunit/releases/tag/$TAG"
