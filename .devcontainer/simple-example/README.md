# Simple Example

このディレクトリには、最もシンプルな devcontainer 設定の例が含まれています。

## 特徴

- ベースイメージのみ使用（UBI9）
- common-utils feature を使用してユーザーセットアップ
- Zsh と Oh My Zsh のサポート
- 最小限の設定

## 使い方

この設定をコピーして、プロジェクトに合わせて features を追加してください：

```bash
cp -r simple-example /path/to/your/project/.devcontainer
```

その後、`devcontainer.json` に必要な features を追加します。

## カスタマイズ例

### Python 開発環境に変更

```json
{
  "features": {
    "ghcr.io/devcontainers/features/common-utils:2": {},
    "ghcr.io/devcontainers/features/python:1": {
      "version": "3.11"
    }
  }
}
```

### Node.js 開発環境に変更

```json
{
  "features": {
    "ghcr.io/devcontainers/features/common-utils:2": {},
    "ghcr.io/devcontainers/features/node:1": {
      "version": "18"
    }
  }
}
```
