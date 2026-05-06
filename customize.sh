ui_print '安装完成'
ui_print '当前架构为' + $ARCH
ui_print '当前系统版本为' + $API

CORE_VERSION_FILE="${MODPATH}/CORE_VERSION"
if [ -f "${CORE_VERSION_FILE}" ]; then
	CORE_VERSION_VALUE="$(cat "${CORE_VERSION_FILE}")"
	ui_print "bitsrungo 最新release版本: ${CORE_VERSION_VALUE}"
else
	ui_print 'bitsrungo 最新release版本: unknown'
fi

ui_print '安装目录为:  /data/adb/modules/bitsrun_magisk'
ui_print '配置文件位置:  /data/adb/modules/bitsrun_magisk/config/config.yaml'
ui_print '如果需要自定义启动参数，可将 /data/adb/modules/bitsrun_magisk/config/command_args_sample 重命名为 command_args，并修改其中内容，使用自定义启动参数时会忽略配置文件'
ui_print '修改配置文件后在magisk app禁用应用再启动即可生效'
ui_print '记得重启'

# 升级时保留原有配置：
# - 若旧配置存在，则覆盖安装包中的配置
# - 若旧配置不存在，则由 config-example.yaml 生成 config.yaml
OLD_CONFIG="/data/adb/modules/bitsrun_magisk/config/config.yaml"
NEW_CONFIG_DIR="${MODPATH}/config"
NEW_CONFIG="${NEW_CONFIG_DIR}/config.yaml"
EXAMPLE_CONFIG="${NEW_CONFIG_DIR}/config-example.yaml"

mkdir -p "${NEW_CONFIG_DIR}"

if [ -f "${OLD_CONFIG}" ]; then
	cp -f "${OLD_CONFIG}" "${NEW_CONFIG}"
	ui_print '检测到旧配置，已保留原 config.yaml'
elif [ ! -f "${NEW_CONFIG}" ] && [ -f "${EXAMPLE_CONFIG}" ]; then
	cp -f "${EXAMPLE_CONFIG}" "${NEW_CONFIG}"
	ui_print '未检测到旧配置，已由 config-example.yaml 生成 config.yaml'
fi
