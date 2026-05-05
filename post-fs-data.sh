#!/system/bin/sh
MODDIR=${0%/*}
MODPATH="/data/adb/modules/bitsrun_magisk"
CONFIG_DIR="${MODDIR}/config"
BACKUP_DIR="/data/adb/bitsrun_magisk_backup"

# 如果模块配置目录存在且备份目录不存在，则备份配置
if [ -d "$CONFIG_DIR" ] && [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p "$BACKUP_DIR"
    
    # 备份关键配置文件
    if [ -f "$CONFIG_DIR/config.yaml" ]; then
        cp "$CONFIG_DIR/config.yaml" "$BACKUP_DIR/config.yaml"
        echo "[bitsrun] Backed up config.yaml" >> "$MODDIR/log.log"
    fi
    
    if [ -f "$CONFIG_DIR/command_args" ]; then
        cp "$CONFIG_DIR/command_args" "$BACKUP_DIR/command_args"
        echo "[bitsrun] Backed up command_args" >> "$MODDIR/log.log"
    fi
fi

# 升级后恢复配置：如果备份目录存在但当前配置已被覆盖，则恢复
if [ -d "$BACKUP_DIR" ]; then
    if [ -f "$BACKUP_DIR/config.yaml" ] && [ ! -f "$CONFIG_DIR/config.yaml" ]; then
        mkdir -p "$CONFIG_DIR"
        cp "$BACKUP_DIR/config.yaml" "$CONFIG_DIR/config.yaml"
        echo "[bitsrun] Restored config.yaml from backup" >> "$MODDIR/log.log"
    fi
    
    if [ -f "$BACKUP_DIR/command_args" ] && [ ! -f "$CONFIG_DIR/command_args" ]; then
        mkdir -p "$CONFIG_DIR"
        cp "$BACKUP_DIR/command_args" "$CONFIG_DIR/command_args"
        echo "[bitsrun] Restored command_args from backup" >> "$MODDIR/log.log"
    fi
fi
