#!/usr/bin/env bash
set -u

readonly INTERNAL_OUTPUT="eDP-1"
readonly INTERNAL_RULE="${INTERNAL_OUTPUT},preferred,auto,1.45703125"

enable_internal() {
    hyprctl keyword monitor "${INTERNAL_RULE}"
}

disable_internal_if_external() {
    local monitors_json
    local external_count

    if ! monitors_json="$(hyprctl monitors -j)"; then
        return 1
    fi

    if ! external_count="$(
        jq -er --arg internal "${INTERNAL_OUTPUT}" \
            '[.[] | select(.name != $internal)] | length' \
            <<<"${monitors_json}"
    )"; then
        return 1
    fi

    if (( external_count > 0 )); then
        hyprctl keyword monitor "${INTERNAL_OUTPUT},disable"
    fi
}

case "${1-}" in
    open)
        enable_internal
        ;;
    close)
        disable_internal_if_external
        ;;
    *)
        printf 'usage: %s open|close\n' "${0##*/}" >&2
        exit 64
        ;;
esac
