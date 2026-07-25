#!/usr/bin/env bash
# base-check.sh — refuse to build on a stale base.
#
# A dispatched builder's MANDATORY FIRST ACTION. The worktree isolation
# machinery has been measured creating worktrees from a session-start
# snapshot days behind live main (2026-07-25: two builders inherited a
# base from 2026-07-24, missing eleven pins), so freshness is verified
# mechanically, never assumed.
#
# Usage:  bash tools/base-check.sh [expected_main_sha]
#   - With an argument (the sha the orchestrator pasted into the brief):
#     HEAD must CONTAIN that sha, or this exits 1.
#   - Without: HEAD must contain the local main branch's current tip.
#
# On failure the builder rebases onto main (git rebase main) and re-runs
# this check — or aborts and reports the staleness. It never builds on
# the stale base.
set -u
want="${1:-$(git rev-parse main)}"
have_base="$(git merge-base HEAD "$want" 2>/dev/null || true)"
if [ "$have_base" = "$(git rev-parse "$want")" ]; then
  echo "base-check: OK — HEAD contains $(git rev-parse --short "$want") (main's tip at dispatch)"
  exit 0
fi
echo "base-check: STALE BASE — HEAD does not contain $(git rev-parse --short "$want")."
echo "  merge-base with it: $(git rev-parse --short "$have_base" 2>/dev/null || echo none)"
echo "  HEAD:               $(git log -1 --format='%h %ad %s' --date=short HEAD)"
echo "  Rebase onto main (git rebase main) and re-run, or abort and report."
exit 1
