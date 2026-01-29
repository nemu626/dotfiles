#!/usr/bin/env bash
set -euo pipefail

# active window の class を取得（Hyprland）
class="$(hyprctl activewindow -j | jq -r '.class // ""')"

case "$class" in
  firefox|Firefox)
    # Ctrl+W を active window へ送る（タブを閉じる）
    hyprctl dispatch sendshortcut "CTRL, W, activewindow"
    ;;
  google-chrome|Google-chrome|chromium|Chromium|brave-browser|Brave-browser|vivaldi-stable|Vivaldi-stable)
    hyprctl dispatch sendshortcut "CTRL, W, activewindow"
    ;;
  *)
    # ブラウザ以外では何もしない
    exit 0
    ;;
esac

