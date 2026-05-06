#!/data/adb/magisk/busybox sh
MODDIR=${0%/*}
MODULE_PROP="${MODDIR}/module.prop"

# 更新module.prop文件中的description
update_module_description() {
  local status_message=$1
  sed -i "/^description=/c\description=[状态]${status_message}" ${MODULE_PROP}
}

# MODDIR="$(dirname $(readlink -f "$0"))"
chmod 755 ${MODDIR}/*

# 等待系统启动成功
while [ "$(getprop sys.boot_completed)" != "1" ]; do
  sleep 5s
done

# 防止系统挂起
echo "PowerManagerService.noSuspend" > /sys/power/wake_lock

# 启动守护脚本前先同步一次状态
if [ -f "${MODDIR}/disable" ]; then
  update_module_description "已关闭"
elif pgrep -f 'bitsrun' >/dev/null; then
  if [ -f "${MODDIR}/config/command_args" ]; then
    update_module_description "主程序已开启(启动参数模式)"
  else
    update_module_description "主程序已开启(配置文件模式)"
  fi
else
  update_module_description "关闭中"
fi

# 等待 3 秒
sleep 3s

# 启动主程序守护脚本
"${MODDIR}/bitsrun_core.sh" &
