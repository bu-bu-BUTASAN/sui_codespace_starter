# Sui Codespace Starter (No Prebuild)

このリポジトリは、Prebuild を使わずに最小構成の Sui 開発環境を素早く配布するための VS Code Dev Containers / GitHub Codespaces 用テンプレートです。Sui CLI は `suiup`（testnet 系）で導入・更新します。

## 主要構成
- ベースイメージ: `mcr.microsoft.com/devcontainers/base:ubuntu`
- Dev Container Features: Git / Node.js 20
- Sui CLI: `suiup` で `sui@testnet` をインストール
- ライフサイクル:
  - 初回: `.devcontainer/setup.sh` が `suiup` と `sui` を導入
  - 起動毎: `.devcontainer/update-on-start.sh` が `suiup update sui@testnet -y` を実行（失敗は無視）
- PATH: `~/.local/bin` を `remoteEnv.PATH` で追加
- VS Code 拡張: `Mysten.move`

## 使い方
- GitHub Codespaces: このリポジトリで Codespace を作成（Prebuild は不要）
- ローカル VS Code: Dev Containers 拡張を入れ、「Reopen in Container」で起動

初回作成時に Sui CLI が導入され、以後の起動時に自動更新を試行します。

## 動作確認
コンテナのターミナルで次を実行:

```bash
sui --version && node -v && git --version
which sui
```
`which sui` が `~/.local/bin/sui` を指す想定です。

## ローカルネット（任意）
ポートの自動フォワード（目印）: 9000「Sui RPC」/ 9123「Sui Faucet」。

```bash
sui start --with-faucet --force-regenesis
```

## 自動更新のスキップ（任意）
コンテナ起動毎の更新を無効化したい場合は、環境変数を設定してください。

- 一時的に無効化（起動中のシェル）:
  ```bash
  export SKIP_SUI_UPDATE=1
  ```
- 恒久化したい場合は `.devcontainer/devcontainer.json` の `containerEnv` に `"SKIP_SUI_UPDATE": "1"` を追加してください。

## セキュリティ・ポリシー
- スクリプトは冪等で、Secrets やトークンを前提にしません。
- ネットワークアクセスは `suiup` の取得と `apt-get` の最小限に限定しています。

---
不具合や改善要望があれば Issue/Pull Request を歓迎します。
