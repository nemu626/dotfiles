#!/usr/bin/env bash
set -u

readonly ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
readonly HANDLER="${ROOT_DIR}/scripts/lid-switch.sh"
readonly FAKE_BIN="${ROOT_DIR}/tests/bin"

test_log=""

setup() {
    test_log="$(mktemp)"
    export FAKE_HYPRCTL_LOG="${test_log}"
    export FAKE_MONITORS_JSON='[]'
    export FAKE_MONITORS_STATUS=0
    export FAKE_KEYWORD_STATUS=0
}

teardown() {
    rm -f -- "${test_log}"
}

run_handler() {
    PATH="${FAKE_BIN}:${PATH}" "${HANDLER}" "$@"
}

assert_log_contains() {
    local expected="$1"
    if ! grep -Fxq -- "${expected}" "${test_log}"; then
        printf 'expected log line: %s\nactual log:\n' "${expected}" >&2
        sed -n '1,20p' "${test_log}" >&2
        return 1
    fi
}

assert_no_monitor_keyword() {
    if grep -q '^keyword monitor ' "${test_log}"; then
        printf 'unexpected monitor mutation:\n' >&2
        sed -n '1,20p' "${test_log}" >&2
        return 1
    fi
}

test_open_enables_internal() {
    setup
    run_handler open
    assert_log_contains \
        'keyword monitor eDP-1,preferred,auto,1.45703125' || {
        teardown
        return 1
    }
    teardown
}

test_open_failure_is_reported() {
    setup
    export FAKE_KEYWORD_STATUS=1
    if run_handler open; then
        printf 'expected monitor keyword failure\n' >&2
        teardown
        return 1
    fi
    teardown
}

test_close_with_external_disables_internal() {
    setup
    export FAKE_MONITORS_JSON='[{"name":"eDP-1"},{"name":"DP-7"}]'
    run_handler close
    assert_log_contains 'keyword monitor eDP-1,disable' || {
        teardown
        return 1
    }
    teardown
}

test_close_without_external_is_noop() {
    setup
    export FAKE_MONITORS_JSON='[{"name":"eDP-1"}]'
    run_handler close
    assert_no_monitor_keyword || {
        teardown
        return 1
    }
    teardown
}

test_close_query_failure_is_safe() {
    setup
    export FAKE_MONITORS_STATUS=1
    if run_handler close; then
        printf 'expected query failure\n' >&2
        teardown
        return 1
    fi
    assert_no_monitor_keyword || {
        teardown
        return 1
    }
    teardown
}

test_close_invalid_json_is_safe() {
    setup
    export FAKE_MONITORS_JSON='not-json'
    if run_handler close; then
        printf 'expected JSON failure\n' >&2
        teardown
        return 1
    fi
    assert_no_monitor_keyword || {
        teardown
        return 1
    }
    teardown
}

test_invalid_action_is_safe() {
    setup
    if run_handler invalid; then
        printf 'expected invalid action failure\n' >&2
        teardown
        return 1
    fi
    if [[ -s "${test_log}" ]]; then
        printf 'invalid action invoked hyprctl\n' >&2
        teardown
        return 1
    fi
    teardown
}

tests=(
    test_open_enables_internal
    test_open_failure_is_reported
    test_close_with_external_disables_internal
    test_close_without_external_is_noop
    test_close_query_failure_is_safe
    test_close_invalid_json_is_safe
    test_invalid_action_is_safe
)

for test_name in "${tests[@]}"; do
    if ! "${test_name}"; then
        printf 'FAIL: %s\n' "${test_name}" >&2
        exit 1
    fi
    printf 'PASS: %s\n' "${test_name}"
done
