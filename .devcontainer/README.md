# Devcontainer Configurations

このディレクトリには、プロジェクトで使用するための devcontainer 設定が含まれています。

## 概要

devcontainer features を活用することで、必要なツールやモジュールをモジュラー方式で追加できます。これにより、ベースイメージ（UBI9）には一般的なツールのみをインストールし、プロジェクト固有のツールは features として追加できます。

## ディレクトリ構造

```
.devcontainer/
├── base/                    # ベースとなる UBI9 コンテナ
│   ├── Dockerfile
│   └── devcontainer.json
├── terraform/              # Terraform 開発環境の例
│   └── devcontainer.json
├── terraform-aws/          # Terraform + AWS CLI 開発環境の例
│   └── devcontainer.json
├── python-aws/             # Python + AWS CLI 開発環境の例
│   └── devcontainer.json
└── README.md
```

## ベース設定 (base/)

ベース設定には、すべてのプロジェクトで共通に必要な最小限のツールのみが含まれています：

- Git
- Curl/Wget
- Vim
- 圧縮ツール (tar, gzip, unzip)
- jq
- CA証明書

## 使い方

### 1. プロジェクトに適した設定を選択

プロジェクトのルートに `.devcontainer/` ディレクトリを作成し、このリポジトリから適切な設定をコピーします。

### 2. カスタマイズ

必要に応じて、追加の features を `devcontainer.json` に追加します：

```json
{
  "name": "My Project",
  "build": {
    "dockerfile": "Dockerfile"
  },
  "features": {
    "ghcr.io/devcontainers/features/terraform:1": {
      "version": "latest"
    },
    "ghcr.io/devcontainers/features/aws-cli:1": {
      "version": "latest"
    },
    "ghcr.io/devcontainers/features/docker-in-docker:2": {}
  }
}
```

### 3. 新しいプロジェクト向けの設定作成

新しいツールセットが必要な場合は、ベース Dockerfile を参照する新しい `devcontainer.json` を作成します：

```json
{
  "name": "My Custom Environment",
  "image": "registry.access.redhat.com/ubi9/ubi:latest",
  "features": {
    "ghcr.io/devcontainers/features/node:1": {
      "version": "18"
    },
    "ghcr.io/devcontainers/features/python:1": {
      "version": "3.11"
    }
  }
}
```

## 利用可能な Features

devcontainer features は公式およびコミュニティによって多数提供されています：

- **AWS CLI**: `ghcr.io/devcontainers/features/aws-cli:1`
- **Terraform**: `ghcr.io/devcontainers/features/terraform:1`
- **Python**: `ghcr.io/devcontainers/features/python:1`
- **Node.js**: `ghcr.io/devcontainers/features/node:1`
- **Go**: `ghcr.io/devcontainers/features/go:1`
- **Docker-in-Docker**: `ghcr.io/devcontainers/features/docker-in-docker:2`
- **kubectl**: `ghcr.io/devcontainers/features/kubectl-helm-minikube:1`

完全なリストは [devcontainers/features](https://github.com/devcontainers/features) を参照してください。

## 例

### Terraform + AWS プロジェクト

```bash
cp -r .devcontainer/terraform-aws /path/to/your/project/.devcontainer
```

### Python + AWS プロジェクト

```bash
cp -r .devcontainer/python-aws /path/to/your/project/.devcontainer
```

### カスタム設定

ベース Dockerfile を使用して独自の features を追加：

```bash
mkdir -p /path/to/your/project/.devcontainer
cp .devcontainer/base/Dockerfile /path/to/your/project/.devcontainer/
# 独自の devcontainer.json を作成
```

## メリット

1. **モジュラー性**: 必要なツールだけを選択して追加
2. **保守性**: ベースイメージの更新が容易
3. **再利用性**: 同じベースイメージを複数のプロジェクトで使用
4. **標準化**: 公式の devcontainer features を使用することで、メンテナンスされた設定を利用
5. **拡張性**: 新しいツールが必要になったときに簡単に追加可能

## トラブルシューティング

### Features が正しくインストールされない

1. VS Code の Dev Containers 拡張機能が最新版であることを確認
2. コンテナを再ビルド: `Cmd/Ctrl + Shift + P` → "Dev Containers: Rebuild Container"

### カスタム features の追加

プロジェクト固有のツールは、Dockerfile に直接追加するか、独自の feature を作成できます。

## 参考資料

- [Dev Container Features specification](https://containers.dev/implementors/features/)
- [Official Dev Container Features](https://github.com/devcontainers/features)
- [VS Code Dev Containers documentation](https://code.visualstudio.com/docs/devcontainers/containers)
