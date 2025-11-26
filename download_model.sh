#!/bin/bash

# COCO-SSD MobileNet V1 模型下载脚本 (已更新路径和分片数量)
# 脚本将下载所有必要的模型文件到当前目录下的 'model/' 文件夹。

# 修正后的模型基础路径，指向常用的 SSD MobileNet V1 版本
MODEL_URL_BASE="https://storage.googleapis.com/tfjs-models/savedmodel/ssd_mobilenet_v1"
MODEL_DIR="model"

echo "正在创建模型文件夹: $MODEL_DIR"
mkdir -p $MODEL_DIR

echo "正在下载模型配置文件: model.json"
# 使用 -f 选项来处理失败（虽然 GCS 返回 200，但内容是错误 XML，此选项有助于观察）
curl -o $MODEL_DIR/model.json $MODEL_URL_BASE/model.json

# 该模型版本包含4个权重分片文件 (shard1of4 到 shard4of4)
# 修正循环范围
for i in {1..4}; do
    FILE_NAME="group1-shard${i}of4"
    echo "正在下载权重分片: $FILE_NAME"
    curl -o $MODEL_DIR/$FILE_NAME $MODEL_URL_BASE/$FILE_NAME
done

echo ""
echo "下载完成！"
echo "请确认以下文件已存在于 './model/' 文件夹中："
echo "model.json"
echo "group1-shard1of4 到 group1-shard4of4 (共4个文件)"
echo ""
echo "如果 model.json 的内容仍是 XML 错误，请尝试使用浏览器手动下载 model.json。"
echo "现在您可以在断网情况下打开 baby_fence_app.html 运行应用。
