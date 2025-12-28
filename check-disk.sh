# include common
SHELL_DIR=$(dirname "$BASH_SOURCE")
SHELL_PATH=$(cd $SHELL_DIR; pwd)
source $SHELL_PATH/common.sh

echo
echo "check disk status"
echo "----------------------------------------------------"
du -sh $K3S_DATA_DIR







