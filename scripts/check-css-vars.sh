#!/usr/bin/env bash
# Verifica che tutte le variabili CSS usate nei file custom esistano nel tema Chirpy.
# Eseguito come pre-push hook; esce con codice 1 se trova variabili non definite.
#
# Richiede: gh CLI (autenticato), grep, sed, sort, comm

set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
GEMFILE="$REPO_DIR/Gemfile"
GIT_DIR="$REPO_DIR/.git"
CACHE_DIR="$GIT_DIR/chirpy-css-vars-cache"
mkdir -p "$CACHE_DIR"

# ── 1. Trova il tag Chirpy più recente compatibile con il vincolo di versione ──

# Estrai il constraint (es. "7.2" da "~> 7.2")
CHIRPY_CONSTRAINT=$(grep 'jekyll-theme-chirpy' "$GEMFILE" | grep -oP '[\d]+\.[\d]+' | head -1)
if [[ -z "$CHIRPY_CONSTRAINT" ]]; then
  echo "check-css-vars: impossibile leggere la versione di Chirpy dal Gemfile" >&2
  exit 1
fi

MAJOR="${CHIRPY_CONSTRAINT%%.*}"
CACHE_KEY_FILE="$CACHE_DIR/tag-${CHIRPY_CONSTRAINT}.txt"

# Usa il tag in cache se già risolto (vive finché non cambia la constraint nel Gemfile)
if [[ -f "$CACHE_KEY_FILE" ]]; then
  CHIRPY_TAG=$(cat "$CACHE_KEY_FILE")
else
  echo "check-css-vars: risolvo il tag Chirpy per ~> $CHIRPY_CONSTRAINT..."
  CHIRPY_TAG=$(gh api repos/cotes2020/jekyll-theme-chirpy/tags --jq '.[].name' \
    | grep "^v${MAJOR}\." | sort -V | tail -1)
  if [[ -z "$CHIRPY_TAG" ]]; then
    echo "check-css-vars: nessun tag trovato su GitHub per la versione $MAJOR.x" >&2
    exit 1
  fi
  echo "$CHIRPY_TAG" > "$CACHE_KEY_FILE"
fi

# ── 2. Scarica le variabili definite nel tema (con cache per tag) ──

VARS_CACHE="$CACHE_DIR/vars-${CHIRPY_TAG}.txt"

if [[ ! -f "$VARS_CACHE" ]]; then
  echo "check-css-vars: scarico le variabili CSS da Chirpy $CHIRPY_TAG..."

  fetch_vars() {
    local path="$1"
    gh api "repos/cotes2020/jekyll-theme-chirpy/contents/${path}?ref=${CHIRPY_TAG}" \
      --jq '.content' | base64 -d \
      | grep -oP '(?<=^\s{2})(--[\w-]+)(?=:)' || true
  }

  {
    fetch_vars "_sass/themes/_light.scss"
    fetch_vars "_sass/themes/_dark.scss"
  } | sort -u > "$VARS_CACHE"

  COUNT=$(wc -l < "$VARS_CACHE")
  echo "check-css-vars: $COUNT variabili definite (Chirpy $CHIRPY_TAG, cached)"
fi

DEFINED_VARS=$(cat "$VARS_CACHE")

# ── 3. Trova le variabili usate nei file CSS/SCSS custom del repo ──

# File da analizzare: assets/css/ e _sass/ (se esistono nel repo, non nel gem)
SEARCH_DIRS=()
[[ -d "$REPO_DIR/assets/css" ]] && SEARCH_DIRS+=("$REPO_DIR/assets/css")
[[ -d "$REPO_DIR/_sass" ]]      && SEARCH_DIRS+=("$REPO_DIR/_sass")

if [[ ${#SEARCH_DIRS[@]} -eq 0 ]]; then
  echo "check-css-vars: nessuna cartella CSS trovata nel repo, skip." >&2
  exit 0
fi

USED_VARS=$(grep -rh --include="*.scss" --include="*.css" \
  -oP 'var\(\s*--[\w-]+' "${SEARCH_DIRS[@]}" \
  | sed 's/.*\(--[a-zA-Z0-9_-]*\)/\1/' | sort -u)

if [[ -z "$USED_VARS" ]]; then
  echo "check-css-vars: nessun var(--…) trovato nei file custom, OK."
  exit 0
fi

# ── 4. Confronta ──

ERRORS=0
while IFS= read -r var; do
  [[ -z "$var" ]] && continue
  if ! echo "$DEFINED_VARS" | grep -qxF -- "$var"; then
    echo "  ✗ $var  — non definita in Chirpy $CHIRPY_TAG" >&2
    ERRORS=$((ERRORS + 1))
  fi
done <<< "$USED_VARS"

if [[ $ERRORS -gt 0 ]]; then
  echo ""
  echo "check-css-vars: FALLITO — $ERRORS variabile/i CSS non definita/e nel tema." >&2
  echo "Verifica i nomi su: https://github.com/cotes2020/jekyll-theme-chirpy/tree/${CHIRPY_TAG}/_sass/themes/" >&2
  exit 1
fi

TOTAL=$(echo "$USED_VARS" | wc -l)
echo "check-css-vars: OK — $TOTAL variabile/i CSS verificate contro Chirpy $CHIRPY_TAG."
exit 0
