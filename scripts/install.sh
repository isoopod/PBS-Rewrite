#!/bin/sh
set -euo pipefail

# Forward all script arguments to `pesde install`
PESDE_ARGS="$@"

# Check whether rojo is serving
if ! lsof -i :34872 >/dev/null 2>&1; then
    pesde install $PESDE_ARGS

    rm -rf 'roblox_packages/.pesde/roblox_testez@0.4.1'
    echo 'Removed roblox_testez'

    TARGET="roblox_packages/React.luau"
    TMP="$(mktemp /tmp/react.XXXXXX)" || exit 1

    {
        printf '%s\n' '-- selene: allow(global_usage)'
        printf '%s\n' "_G.__DEV__ = game:GetService('RunService'):IsStudio()"
        printf '\n'
        cat "$TARGET"
    } > "$TMP"

    # Replace original file atomically
    mv -f "$TMP" "$TARGET"
    printf 'Updated %s\n' "$TARGET"

    rojo sourcemap --output sourcemap.json default.project.json
else
    echo "Port 34872 is in use; aborting."
    echo "Stop your Rojo Live-Sync server before running this script."
    exit 1
fi