# Sui Codespace Starter

このリポジトリは、最小構成の Sui 開発環境を素早く配布するための VS Code Dev Containers / GitHub Codespaces 用テンプレートです。
Sui CLI は `suiup`（testnet 系）で導入・更新します。

## 主要構成
- ベースイメージ: `mcr.microsoft.com/devcontainers/typescript-node:22-bookworm`（Node 22 + TS/ESLint など同梱）
- Dev Container Features: Git / GitHub CLI（`gh`）
- Sui CLI: `suiup` で `sui@testnet` をインストール
- ライフサイクル:
  - 初回: `.devcontainer/setup.sh` が `suiup` と `sui` を導入
  - 起動毎: `.devcontainer/update-on-start.sh` が `suiup update sui@testnet -y` を実行（失敗は無視）
- PATH: `~/.local/bin` を `remoteEnv.PATH` の先頭に追加（`sui` を優先解決）
- VS Code 拡張機能: `Mysten.move`

## 使い方
- GitHub Codespaces: このリポジトリで Codespace を作成
- ローカル VS Code: Dev Containers 拡張を入れ、「Reopen in Container」で起動

初回作成時に Sui CLI が導入され、以後の起動時に自動更新を試行します。

## 動作確認
コンテナのターミナルで次を実行:

```bash
sui --version && node -v && git --version
which sui
```
`which sui` が `~/.local/bin/sui` を指す想定です。

---
不具合や改善要望があれば Issue/Pull Request を歓迎します。
