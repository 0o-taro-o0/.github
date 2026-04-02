#!/usr/bin/env bash
# =============================================================================
# setup.sh — 環境セットアップスクリプト
# =============================================================================
# 使い方:
#   1. .env.example をコピーして .env を作成し、各変数を設定する
#        cp .env.example .env
#   2. このスクリプトを実行する
#        bash setup.sh
# =============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_FILE="${SCRIPT_DIR}/.env"
ENV_EXAMPLE_FILE="${SCRIPT_DIR}/.env.example"

# ---------------------------------------------------------------------------
# .env ファイルの読み込み
# ---------------------------------------------------------------------------
load_env() {
  local file="$1"
  echo "[setup] 環境変数を読み込みます: ${file}"
  # ファイル内の変数をすべて export する（bash はコメント行・空行を無視する）
  set -o allexport
  # shellcheck source=/dev/null
  source "${file}"
  set +o allexport
}

if [[ -f "${ENV_FILE}" ]]; then
  load_env "${ENV_FILE}"
elif [[ -f "${ENV_EXAMPLE_FILE}" ]]; then
  echo "[setup] WARNING: .env が見つかりません。.env.example を使用します。"
  echo "[setup]          本番環境では必ず .env.example をコピーして .env を作成してください。"
  load_env "${ENV_EXAMPLE_FILE}"
else
  echo "[setup] ERROR: .env および .env.example が見つかりません。" >&2
  echo "[setup]        リポジトリルートに .env.example が存在することを確認してください。" >&2
  exit 1
fi

# ---------------------------------------------------------------------------
# 必須変数の検証
# ---------------------------------------------------------------------------
required_vars=(
  APP_NAME
  APP_ENV
  APP_PORT
)

missing=()
for var in "${required_vars[@]}"; do
  if [[ -z "${!var:-}" ]]; then
    missing+=("${var}")
  fi
done

if [[ ${#missing[@]} -gt 0 ]]; then
  echo "[setup] ERROR: 次の必須変数が設定されていません:" >&2
  for var in "${missing[@]}"; do
    echo "         - ${var}" >&2
  done
  echo "[setup]        .env ファイルを確認してください。" >&2
  exit 1
fi

# ---------------------------------------------------------------------------
# セットアップ処理
# ---------------------------------------------------------------------------
echo "[setup] アプリケーション名 : ${APP_NAME}"
echo "[setup] 実行環境           : ${APP_ENV}"
echo "[setup] ポート番号         : ${APP_PORT}"
echo "[setup] セットアップを開始します..."

# ここに環境ごとの初期化処理を追加してください
# 例:
#   - 依存パッケージのインストール
#   - データベースのマイグレーション
#   - 設定ファイルの生成

echo "[setup] セットアップが完了しました。"
