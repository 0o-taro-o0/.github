# デプロイ手順

## 事前準備

### 1. リポジトリのクローン

```bash
git clone <リポジトリURL>
cd <リポジトリ名>
```

### 2. 環境変数ファイルの作成

`.env.example` をコピーして `.env` を作成し、各変数を環境に合わせて設定します。

```bash
cp .env.example .env
```

`.env` を開き、必要な変数を設定してください。各変数の説明は `.env.example` 内のコメントを参照してください。

> **注意**: `.env` には機密情報（パスワード、シークレットキーなど）が含まれます。
> `.env` は `.gitignore` により Git 管理対象外になっています。絶対にコミットしないでください。

### 3. セットアップの実行

```bash
bash setup.sh
```

スクリプトは以下の処理を行います:

1. `.env` ファイルを読み込んで環境変数を設定する
2. 必須変数が設定されているか検証する
3. 環境ごとの初期化処理を実行する

---

## 環境ごとの設定

### ローカル開発環境

`.env` の `APP_ENV` を `development` に設定します。

```dotenv
APP_ENV=development
```

### ステージング環境

`.env` の `APP_ENV` を `staging` に設定します。

```dotenv
APP_ENV=staging
```

### 本番環境

`.env` の `APP_ENV` を `production` に設定します。

```dotenv
APP_ENV=production
```

> **注意**: 本番環境では `SECRET_KEY` に十分にランダムな文字列を設定してください。
>
> ```bash
> openssl rand -hex 32
> ```

---

## トラブルシューティング

### `.env` が見つからないと警告が出る

`.env.example` をコピーして `.env` を作成してください。

```bash
cp .env.example .env
```

### 必須変数が未設定のエラーが出る

`.env` を開き、`APP_NAME`・`APP_ENV`・`APP_PORT` が設定されているか確認してください。

### 環境変数を追加したい場合

1. `.env.example` に変数名・説明コメント・デフォルト値を追加する
2. `setup.sh` の `required_vars` 配列に必須変数として追加する（任意）
3. `.env` に実際の値を設定する
4. `README.md` および本ドキュメントの説明を更新する
