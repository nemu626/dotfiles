# 🏠 Dotfiles

Arch Linux + Hyprland の設定ファイル群

![Hyprland](https://img.shields.io/badge/Hyprland-58E1FF?style=flat-square&logo=wayland&logoColor=white)
![Arch Linux](https://img.shields.io/badge/Arch%20Linux-1793D1?style=flat-square&logo=arch-linux&logoColor=white)
![Catppuccin](https://img.shields.io/badge/Catppuccin-Mocha-cba6f7?style=flat-square)

## 📦 含まれる設定

| アプリケーション | 説明 |
|---|---|
| **Hyprland** | Waylandコンポジター |
| **Waybar** | ステータスバー |
| **Ghostty** | ターミナルエミュレータ |
| **Zsh** | シェル + エイリアス |
| **Starship** | プロンプト |
| **Rofi** | アプリケーションランチャー |
| **Dunst** | 通知デーモン |

## 🎨 テーマ

**Catppuccin Mocha** を全体で統一使用

## ⚡ クイックスタート

### 1. リポジトリのクローン

```bash
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 2. インストール

```bash
# シンボリックリンクのみ作成
./create_link.sh

# パッケージをインストール
./install_base.sh

# CLIツールをインストール（mise/config.toml でバージョン管理）
# Arch: paru -S mise or yay -S mise / macOS: brew install mise
./install_cli_tools.sh
```

#### macOS (Homebrew)

macOSでHomebrewを使う場合は、`mac/`内のスクリプトを使います。

```bash
# Homebrew（未導入なら mac/install_base.sh が導入を試みます）
./mac/install_base.sh

# CLI ツール（mise/config.toml でバージョン管理）
./mac/install_cli_tools.sh

# mac向けのシンボリックリンク（mise/zsh/vim/sheldon/starship/gitなど）
./mac/create_link.sh
```

#### miseの設定

共通設定は `mise/config.toml` にまとめ、両OSのリンク作成スクリプトから
`~/.config/mise/config.toml` にリンクします。既存のファイルはバックアップされます。
別のマシンで適用するときは、そのマシン固有のツール指定を共通設定と比較してからリンクしてください。

Nodeは `24.22.1`、pnpmは `10.33.0`、Yarnは `v4` を共通の既定値にしています。
プロジェクトごとに別のバージョンが必要な場合は、そのプロジェクトの `mise.toml` で指定します。
たとえばYarn 1が必要なプロジェクトでは `mise use yarn@v1` を実行します。

追加ツールの一覧は `mise/config.extras.toml` に保存しています。通常のシェルでは読み込まれません。
Homebrewやpacmanで導入済みのCLIも含むため、miseでも管理したい場合に読み込んでください。

```bash
# dotfilesディレクトリで、追加ツールもインストール
mise -E extras install

# 追加ツールをmise経由で実行する例
mise -E extras exec -- lazygit
```

### 3. 再ログイン

設定を反映させるため、ログアウトして再ログインしてください。

## 📁 ディレクトリ構造

```
dotfiles/
├── hypr/               # Hyprland設定
│   ├── hyprland.conf   # メイン設定
│   ├── keybinds.conf   # キーバインド
│   ├── autostart.conf  # 自動起動
│   ├── theme.conf      # テーマカラー
│   └── scripts/        # ユーティリティ
├── waybar/             # ステータスバー
├── ghostty/            # ターミナル
├── zsh/                # シェル設定
├── starship/           # プロンプト
├── rofi/               # ランチャー
├── dunst/              # 通知
└── nvim/               # エディタ
```

## ⌨️ 主なキーバインド

| キー | アクション |
|---|---|
| `Super + Enter` | ターミナル起動 |
| `Super + D` | Rofi (アプリランチャー) |
| `Super + Q` | ウィンドウを閉じる |
| `Super + F` | フルスクリーン |
| `Super + V` | フローティング切り替え |
| `Super + 1-9` | ワークスペース移動 |
| `Super + Shift + 1-9` | ウィンドウを移動 |
| `Super + H/J/K/L` | フォーカス移動 |

## 🛠️ 依存パッケージ

<details>
<summary>クリックで展開</summary>

### Hyprland エコシステム
- `hyprland` `waybar` `dunst` `rofi-wayland` `swww`
- `xdg-desktop-portal-hyprland`

### ターミナル & シェル
- `ghostty` `zsh` `starship`

### ユーティリティ
- `grim` `slurp` `wl-clipboard` `cliphist`
- `pamixer` `playerctl` `brightnessctl`

### CLI ツール
- `bat` `eza` `fd` `ripgrep` `zoxide` `bottom`
- `git-delta` `gitui` `dust` `broot`

### フォント
- `ttf-jetbrains-mono-nerd`
- `noto-fonts-cjk`

</details>

## 📝 ライセンス

MIT
