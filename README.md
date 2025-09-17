# Sui Codespace Starter

このリポジトリは、最小構成の Sui 開発環境を素早く配布するための VS Code Dev Containers / GitHub Codespaces 用テンプレートです。
Sui CLI は Mysten Labs 公式イメージと `suiup` を組み合わせて自動導入・更新します。

## 主要構成
- ベースイメージ: Mysten Labs 公式 `mysten/sui-tools:devnet`
- Dev Container Features: Git / GitHub CLI（`gh`）/ Node.js 22（devcontainers features を使用）
- Sui CLI: 公式イメージに同梱し、コンテナ起動毎に `.devcontainer/update-on-start.sh` で最新ビルドへ自動更新（既定は `sui@devnet`）。
- PATH: `~/.local/bin` を `remoteEnv.PATH` の先頭に追加（手元インストールを優先解決するため）
- VS Code 拡張機能: `Mysten.move`

## 使い方

### ローカル（VS Code Dev Container）
前提: VS Code / Docker Desktop / Dev Containers 拡張（ms-vscode-remote.remote-containers）をインストール済み。

1. このリポジトリをクローンして VS Code で開く。
2. 画面右下のポップアップ、またはコマンドパレットから「Reopen in Container」を実行。
3. 初回は Mysten 公式イメージの取得後、起動時スクリプトが `sui@devnet` を自動更新します。
4. ターミナルで次を実行し、環境を確認:
   ```bash
   sui --version && node -v && git --version && gh --version
   which sui   # 通常は ~/.local/bin/sui を指します
   ```

ヒント:
- 最新のベースイメージを取り直したい場合は、コマンドパレットで「Dev Containers: Rebuild Without Cache」。
- ネットワークを切り替えたい場合は `SUIUP_PROFILE` を `sui@testnet` などに変更（下記「よく使う環境変数」参照）。

### クラウド（GitHub Codespaces）
前提: GitHub アカウントと Codespaces 利用権限。

1. GitHub のリポジトリページで「Code」→「Codespaces」→「Create codespace on main」。
2. 起動後、自動で Dev Container 設定を読み込み、`sui@devnet` を更新します。
3. ターミナルでローカル同様の確認コマンドを実行。

ヒント:
- ベースイメージを取り直したい場合はコマンドパレットで「Codespaces: Rebuild Container」。

## よく使う環境変数
- `SUIUP_PROFILE`: 既定は `sui@devnet`。`sui@testnet` や `sui@mainnet` に切り替えたい場合は `devcontainer.json` の `containerEnv` で上書きしてください。

## 動作確認
コンテナのターミナルで次を実行:

```bash
sui --version && node -v && git --version
which sui
```
`which sui` が `~/.local/bin/sui` を指す想定です（更新が行われなかった場合は `/usr/local/bin/sui` になることがあります）。

---
不具合や改善要望があれば Issue/Pull Request を歓迎します。
