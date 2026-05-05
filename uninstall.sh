MODDIR=${0%/*}
# 结束 bitsrun 进程（若存在）
pkill bitsrun 2>/dev/null || true

rm -rf $MODDIR/*