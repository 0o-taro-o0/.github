# Devcontainer Features の使い方

## はじめに

このドキュメントでは、このリポジトリで提供される devcontainer 設定を使用して、プロジェクトの開発環境をセットアップする方法を説明します。

## 前提条件

- Visual Studio Code
- Dev Containers 拡張機能
- Docker Desktop または互換性のある Docker 環境

## クイックスタート

### 1. Terraform プロジェクトの場合

```bash
# プロジェクトのルートディレクトリで実行
mkdir -p .devcontainer
curl -o .devcontainer/devcontainer.json https://raw.githubusercontent.com/0o-taro-o0/.github/main/.devcontainer/terraform/devcontainer.json

# または、このリポジトリから直接コピー
cp /path/to/.github/.devcontainer/terraform/* .devcontainer/
```

VS Code でプロジェクトを開き、コマンドパレット（`Cmd/Ctrl + Shift + P`）から **"Dev Containers: Reopen in Container"** を選択します。

### 2. Terraform + AWS プロジェクトの場合

```bash
mkdir -p .devcontainer
cp /path/to/.github/.devcontainer/terraform-aws/* .devcontainer/
```

### 3. Python + AWS プロジェクトの場合

```bash
mkdir -p .devcontainer
cp /path/to/.github/.devcontainer/python-aws/* .devcontainer/
```

### 4. フルスタック開発（Node.js + Python + Docker）の場合

```bash
mkdir -p .devcontainer
cp /path/to/.github/.devcontainer/fullstack/* .devcontainer/
```

## カスタマイズ

### 追加の Features を加える

既存の `devcontainer.json` に features を追加できます：

```json
{
  "features": {
    "ghcr.io/devcontainers/features/terraform:1": {
      "version": "latest"
    },
    "ghcr.io/devcontainers/features/aws-cli:1": {
      "version": "latest"
    },
    // 新しい feature を追加
    "ghcr.io/devcontainers/features/kubectl-helm-minikube:1": {
      "version": "latest",
      "kubectl": "latest",
      "helm": "latest"
    }
  }
}
```

### よく使用される Features

#### クラウドプロバイダー
- **AWS CLI**: `ghcr.io/devcontainers/features/aws-cli:1`
- **Azure CLI**: `ghcr.io/devcontainers/features/azure-cli:1`
- **Google Cloud SDK**: `ghcr.io/devcontainers/features/google-cloud-cli:1`

#### インフラストラクチャー
- **Terraform**: `ghcr.io/devcontainers/features/terraform:1`
- **Ansible**: `ghcr.io/devcontainers-contrib/features/ansible:2`
- **kubectl**: `ghcr.io/devcontainers/features/kubectl-helm-minikube:1`

#### プログラミング言語
- **Python**: `ghcr.io/devcontainers/features/python:1`
- **Node.js**: `ghcr.io/devcontainers/features/node:1`
- **Go**: `ghcr.io/devcontainers/features/go:1`
- **Rust**: `ghcr.io/devcontainers/features/rust:1`
- **Java**: `ghcr.io/devcontainers/features/java:1`

#### ツール
- **Docker-in-Docker**: `ghcr.io/devcontainers/features/docker-in-docker:2`
- **Git LFS**: `ghcr.io/devcontainers/features/git-lfs:1`
- **GitHub CLI**: `ghcr.io/devcontainers/features/github-cli:1`

### VS Code 拡張機能の追加

`devcontainer.json` の `customizations.vscode.extensions` セクションに拡張機能を追加できます：

```json
{
  "customizations": {
    "vscode": {
      "extensions": [
        "hashicorp.terraform",
        "ms-python.python",
        "amazonwebservices.aws-toolkit-vscode",
        "ms-azuretools.vscode-docker"
      ]
    }
  }
}
```

### 環境変数の設定

プロジェクト固有の環境変数を設定できます：

```json
{
  "remoteEnv": {
    "AWS_REGION": "ap-northeast-1",
    "TF_LOG": "DEBUG"
  }
}
```

## 実践例

### 例1: 既存プロジェクトに Terraform 環境を追加

1. プロジェクトのルートに `.devcontainer` ディレクトリを作成
2. `devcontainer.json` を作成：

```json
{
  "name": "My Terraform Project",
  "image": "registry.access.redhat.com/ubi9/ubi:latest",
  "features": {
    "ghcr.io/devcontainers/features/terraform:1": {
      "version": "1.6.0",
      "tflint": "latest",
      "terragrunt": "latest"
    },
    "ghcr.io/devcontainers/features/aws-cli:1": {
      "version": "latest"
    }
  },
  "customizations": {
    "vscode": {
      "extensions": [
        "hashicorp.terraform",
        "amazonwebservices.aws-toolkit-vscode"
      ]
    }
  }
}
```

### 例2: マルチステージビルドが必要な場合

カスタム Dockerfile を使用する場合：

```dockerfile
# .devcontainer/Dockerfile
FROM registry.access.redhat.com/ubi9/ubi:latest

# プロジェクト固有のパッケージをインストール
RUN dnf install -y \
    git \
    vim \
    && dnf clean all

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME

USER $USERNAME
```

```json
{
  "name": "Custom Project",
  "build": {
    "dockerfile": "Dockerfile"
  },
  "features": {
    "ghcr.io/devcontainers/features/terraform:1": {
      "version": "latest"
    }
  }
}
```

### 例3: Docker-in-Docker を使用する場合

Docker コンテナ内で Docker コマンドを実行する必要がある場合：

```json
{
  "name": "Docker-in-Docker Project",
  "image": "registry.access.redhat.com/ubi9/ubi:latest",
  "features": {
    "ghcr.io/devcontainers/features/docker-in-docker:2": {
      "version": "latest"
    }
  },
  "mounts": [
    "source=/var/run/docker.sock,target=/var/run/docker.sock,type=bind"
  ]
}
```

## トラブルシューティング

### コンテナのビルドに失敗する

1. Docker Desktop が起動しているか確認
2. キャッシュをクリアして再ビルド：
   - コマンドパレット → "Dev Containers: Rebuild Container Without Cache"

### Feature がインストールされない

1. Dev Containers 拡張機能が最新版か確認
2. `devcontainer.json` の構文エラーをチェック
3. コンテナログを確認：コマンドパレット → "Dev Containers: Show Container Log"

### 権限の問題

ユーザー権限が必要な場合は、`remoteUser` を適切に設定：

```json
{
  "remoteUser": "vscode"
}
```

または、root ユーザーが必要な場合：

```json
{
  "remoteUser": "root"
}
```

## ベストプラクティス

1. **最小限の Features を使用**: 必要な features のみを追加し、コンテナサイズを小さく保つ
2. **バージョンの固定**: 本番環境では、特定のバージョンを指定して一貫性を保つ
3. **ドキュメント化**: プロジェクトの README に devcontainer の使い方を記載
4. **チームで共有**: `.devcontainer` をリポジトリに含めてチーム全体で同じ環境を使用
5. **定期的な更新**: Features や拡張機能を定期的に更新してセキュリティパッチを適用

## 参考リンク

- [Dev Containers 仕様](https://containers.dev/)
- [公式 Features カタログ](https://containers.dev/features)
- [VS Code Dev Containers ドキュメント](https://code.visualstudio.com/docs/devcontainers/containers)
- [Feature の作成方法](https://containers.dev/implementors/features/)

## サポート

質問や問題がある場合は、このリポジトリの Issues で報告してください。
