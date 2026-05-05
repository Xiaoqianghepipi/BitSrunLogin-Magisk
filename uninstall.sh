MODDIR=${0%/*}
# 结束 bitsrun 进程（若存在）
pkill bitsrun 2>/dev/null || true

# 清理备份的配置文件
rm -rf /data/adb/bitsrun_magisk_backup 2>/dev/null || true

rm -rf $MODDIR/*