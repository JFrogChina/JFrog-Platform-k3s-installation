echo
echo "kfs common start"
echo "****************************************************"

echo
echo "the ENABLED versions defined in version.json to install"
echo

VERSIONS_FILE="version.json"

# read the first "ENABLED": true
combo=$(awk '
    BEGIN { inside = 0; enabled = 0; out = "" }
    /{/ { inside = 1; out = "" }
    inside {
        out = out $0 "\n"
        if ($0 ~ /"ENABLED"[[:space:]]*:[[:space:]]*true/) enabled = 1
    }
    /}/ {
        if (inside && enabled) {
            print out
            exit
        }
        inside = 0
        enabled = 0
    }
' "$VERSIONS_FILE")

if [ -z "$combo" ]; then
    echo "❌ cannot find any "ENABLED": true in version.json"
    return 1
fi

tmpfile=$(mktemp)
echo "$combo" | grep ':' | sed -E 's/[",]//g' > "$tmpfile"

while IFS=':' read -r key value; do
    key=$(echo "$key" | tr -d '[:space:]' | tr -d '"')
    value=$(echo "$value" | sed 's/^[[:space:]]*//;s/[",]//g')

    case "$key" in
        JFROG_CHART_VERSION|K3S_ARCH|K3S_VERSION|HELM_OS|HELM_ARCH|HELM_VERSION)
            export "$key=$value"
            echo "$key=$value"
            ;;
    esac
done < "$tmpfile"

rm -f "$tmpfile"

echo

# kfs path
SHELL_DIR=$(dirname "$BASH_SOURCE")

APP_DIR=$(cd $SHELL_DIR; pwd)

DOWNLOAD_DIR=$APP_DIR/download
DOWNLOAD_DIR_K3S=$APP_DIR/download/k3s
DOWNLOAD_DIR_HELM=$APP_DIR/download/helm
DOWNLOAD_DIR_JFROG=$APP_DIR/download/jfrog

K3S_DATA_DIR=$APP_DIR/k3s-data-dir
# make sure dir exists, possible not included when packaging
mkdir -p $K3S_DATA_DIR
mkdir -p $K3S_DATA_DIR/agent/images/

echo "APP_DIR is $APP_DIR"
echo "DOWNLOAD_DIR is $DOWNLOAD_DIR"
echo "K3S_DATA_DIR is $K3S_DATA_DIR"

echo
echo "kfs common end"
echo "****************************************************"

