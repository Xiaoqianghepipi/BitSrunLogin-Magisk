# bitsrun_magisk 版模块

## 使用教程

下载release里的bitsrun_magisk.zip，在magisk里安装后，编辑好配置文件后重启设备

目录位置: /data/adb/modules/bitsrun_magisk
配置文件位置: /data/adb/modules/bitsrun_magisk/config/config.yaml
修改配置文件后，在 magisk 里禁用再启用模块即可生效

## 配置文件保留

升级/安装时，配置文件按以下规则处理：

- 如果检测到旧的 `config/config.yaml`，则保留旧配置，不覆盖原有配置
- 如果不存在 `config/config.yaml`，则由 `config/config-example.yaml` 为模板自动生成
- 模块默认使用 `config/config.yaml`

## 原项目

<https://github.com/Mmx233/BitSrunLoginGo>
