#!/data/adb/magisk/busybox sh
MODDIR=${0%/*}
MODULE_PROP="${MODDIR}/module.prop"

ET_STATUS=""

# 更新module.prop文件中的description
update_module_description() {
    local status_message=$1
    sed -i "/^description=/c\description=[状态]${status_message}" ${MODULE_PROP}
}

if [ -f "${MODDIR}/disable" ]; then
    ET_STATUS="已关闭"
elif pgrep -f 'bitsrun' >/dev/null; then
    if [ -f "${MODDIR}/config/command_args" ]; then
        ET_STATUS="主程序已开启(启动参数模式)"
    else
        ET_STATUS="主程序已开启(配置文件模式)"
    fi
fi

# ET_STATUS不存在说明主程序未正常运行，不修改状态
if [ -n "$ET_STATUS" ]; then
    update_module_description "${ET_STATUS}"
else
    echo "主程序未正常启动，请先检查配置文件"
fi
