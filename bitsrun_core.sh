#!/system/bin/sh

MODDIR=${0%/*}
CONFIG_FILE="${MODDIR}/config/config.yaml"
MODULE_PROP="${MODDIR}/module.prop"
BITSRUN_BIN="${MODDIR}/bitsrun"

# 进入模块目录，保证 command_args 里使用相对路径时可用
cd "${MODDIR}" || exit 1

# 更新module.prop文件中的description
update_module_description() {
    local status_message=$1
    sed -i "/^description=/c\description=[状态]${status_message}" ${MODULE_PROP}
}

while true; do
    if ls $MODDIR | grep -q "disable"; then
        update_module_description "关闭中"
        if pgrep -f 'bitsrun' >/dev/null; then
            echo "开关控制$(date "+%Y-%m-%d %H:%M:%S") 进程已存在，正在关闭 ..."
            pkill bitsrun # 关闭进程
        fi
    else
        if ! pgrep -f 'bitsrun' >/dev/null; then
            if [ ! -f "$CONFIG_FILE" ]; then
                update_module_description "config.yaml不存在"
                sleep 2s
                continue
            fi

            # 如果 config 目录下存在 command_args 文件，则读取其中的内容作为启动参数
            if [ -f "${MODDIR}/config/command_args" ]; then
                TZ=Asia/Shanghai ${BITSRUN_BIN} $(cat ${MODDIR}/config/command_args) &
                sleep 3s # 等待bitsrun主程序启动完成
                update_module_description "主程序已开启(启动参数模式)"
            else
                TZ=Asia/Shanghai ${BITSRUN_BIN} -config ${CONFIG_FILE} &
                sleep 3s # 等待bitsrun主程序启动完成
                update_module_description "主程序已开启(配置文件模式)"
            fi
            if ! pgrep -f 'bitsrun' >/dev/null; then
                update_module_description "主程序启动失败，请检查配置文件"
            fi
        else
            echo "开关控制$(date "+%Y-%m-%d %H:%M:%S") 进程已存在"
        fi
    fi
    
    sleep 5s # 暂停5秒后再次执行循环
done
