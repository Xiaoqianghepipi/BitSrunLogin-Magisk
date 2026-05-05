## bitsrun_magisk 版模块

# 使用教程

下载release里的bitsrun_magisk.zip，在magisk里安装后，编辑好配置文件后重启设备

目录位置: /data/adb/modules/bitsrun_magisk
配置文件位置: /data/adb/modules/bitsrun_magisk/config/config.yaml
修改配置文件后，在 magisk 里禁用再启用模块即可生效

## 配置文件保留

升级模块时，配置文件会自动保留：
- 首次启动时，模块会自动备份配置文件到 `/data/adb/bitsrun_magisk_backup/`
- 升级后，如果配置文件被覆盖，会自动从备份恢复
- 卸载模块时，备份文件会被清理

## 原项目：

https://github.com/Mmx233/BitSrunLoginGo
