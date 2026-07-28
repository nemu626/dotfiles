# Lid-driven Display Profile Design

## Goal

Automatically control the laptop's internal display from the lid state while
leaving external display placement to Hyprland:

- When the lid is open, the internal display is active whether or not an
  external display is connected.
- When the lid is closed and at least one external display is active, the
  internal display is disabled.
- When the lid is closed with no external display, display automation does
  nothing and the existing systemd-logind policy suspends the laptop.
- External displays use preferred modes and automatic placement and scaling.

## Current Environment

- Hyprland 0.56.0
- Internal output: `eDP-1` (`Lenovo Group Limited 0x403C`)
- Lid switch: `Lid Switch`
- Internal display scale: `1.45703125`
- The existing systemd-logind policy suspends on a normal lid close and ignores
  the lid while docked.
- `dms/outputs.conf` is generated state and currently supplies a fixed monitor
  profile. DMS autostart is disabled in the tracked Hyprland configuration.

## Chosen Approach

Use Hyprland lid switch bindings and a small one-shot shell script. Do not add a
resident event listener or an external profile manager.

This is intentionally the smallest implementation. It reacts to lid events but
does not react to an external display being connected or removed while the lid
remains closed. In that case, opening and closing the lid applies the new state.

## Configuration Ownership

Remove the generated DMS output profile from Hyprland's sourced configuration.
The generic tracked monitor rule remains the default:

```text
monitor=,preferred,auto,auto
```

This makes Hyprland responsible for preferred modes and automatic placement and
scaling for all external displays. The lid handler applies only the runtime
override for `eDP-1`.

The generated `monitors.conf`, `monitors.lua`, and DMS profile files are not used
as the source of truth for this automation.

## Components

### Lid handler

Add `scripts/lid-switch.sh` with two commands:

- `close`
  1. Query active outputs with `hyprctl monitors -j`.
  2. Count active outputs whose name is not `eDP-1`.
  3. Disable `eDP-1` only when that count is at least one.
- `open`
  1. Enable `eDP-1` with its preferred mode, automatic position, and scale
     `1.45703125`.

The script uses `jq`, which is already used by the repository's scripts.

### Lid bindings

Add locked lid bindings for the discovered switch name:

- `switch:on:Lid Switch` invokes the handler with `close`.
- `switch:off:Lid Switch` invokes the handler with `open`.

Locked bindings allow the display state to be corrected even while the session
is locked.

## Failure Behavior

Safety takes precedence over forcing a profile:

- If `hyprctl` fails or returns invalid JSON, the close action leaves the
  internal display active.
- If no external display is active, the close action never disables `eDP-1`.
- Unknown handler arguments return a non-zero status without changing monitor
  state.
- The open action reports a failure if Hyprland cannot enable `eDP-1`.

This prevents a failed monitor query from leaving the user with no active
display.

## Interaction With Suspend

The repository does not modify systemd-logind. Its existing effective policy is:

```ini
HandleLidSwitch=suspend
HandleLidSwitchExternalPower=suspend
HandleLidSwitchDocked=ignore
LidSwitchIgnoreInhibited=no
```

Therefore, closing the lid without an external display continues to suspend the
laptop. With an external display connected, logind ignores the docked lid event
and Hyprland disables only the internal output.

## Verification

- Run `shellcheck` on the new handler.
- Test the handler with a fake `hyprctl` executable and monitor JSON fixtures:
  - open always requests activation of `eDP-1`;
  - close with an external output requests disablement;
  - close with only `eDP-1` makes no display change;
  - close with failed or invalid monitor output makes no display change;
  - an invalid action makes no display change and fails.
- Reload the Hyprland configuration and inspect `hyprctl configerrors`.
- Inspect `hyprctl binds` to confirm both `Lid Switch` bindings.

No automated test will close the real lid or disable a real output.
