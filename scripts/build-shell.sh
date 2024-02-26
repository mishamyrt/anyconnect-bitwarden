#!/bin/bash
set -e

BUILD_DIR="build"
TARGET_FILE="$BUILD_DIR/anyconnect-bitwarden"
SCRIPT_PATH="src/anyconnect-bitwarden.scpt"

rm -f "$TARGET_FILE"
mkdir -p "$BUILD_DIR"
script_content="$(cat $SCRIPT_PATH)"
{
    echo "#!/bin/bash"
    echo "read -r -d '' SCRIPT_CONTENT << EOM"
    echo "$script_content"
    echo "EOM"
    echo "osascript -e \"\$SCRIPT_CONTENT\""
} > "$TARGET_FILE"
chmod +x "$TARGET_FILE"
echo "✅ Shell script generated: $TARGET_FILE"