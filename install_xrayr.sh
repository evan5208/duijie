#!/bin/bash

# 检查 NodeID 是否提供
if [ -z "$1" ]; then
  echo "请提供 NodeID."
  exit 1
fi

# 设置 NodeID
NODE_ID=$1

# 安装 XrayR
echo "正在安装 XrayR..."
bash <(curl -Ls https://raw.githubusercontent.com/XrayR-project/XrayR-release/master/install.sh)

# 检查安装是否成功
if [ $? -ne 0 ]; then
  echo "XrayR 安装失败."
  exit 1
fi

# 切换到 XrayR 配置目录
echo "切换到 /etc/XrayR 目录..."
cd /etc/XrayR || { echo "无法切换到 /etc/XrayR 目录"; exit 1; }

# 从 GitHub 下载配置模板
echo "下载配置模板..."
curl -o config_template.yml https://raw.githubusercontent.com/your-repo/your-project/main/config_template.yml

# 读取模板文件，并替换 NODE_ID
echo "生成配置文件..."
sed "s/{{NODE_ID}}/$NODE_ID/g" config_template.yml > config.yml

# 检查配置文件生成是否成功
if [ $? -ne 0 ]; then
  echo "配置文件生成失败."
  exit 1
fi

echo "配置文件已生成: config.yml"
