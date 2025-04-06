#!/bin/bash

#SBATCH --account=hywang
#SBATCH --job-name=reasoning
#SBATCH --partition=A100 # 用sinfo命令可以看到所有队列
#SBATCH --nodes=1           # 申请的节点数量，单机训练无需调整
#SBATCH --ntasks-per-node=1 # 若多卡或多进程，请调整此参数
#SBATCH --cpus-per-task=8  # 每个进程的CPU数量
#SBATCH --gres=gpu:1        # 若使用2块卡，则gres=gpu:2
#SBATCH --output=../lumia-output/%j.out     # 设置标准输出的文件路径
#SBATCH --error=../lumia-output/%j.err      # 设置标准错误的文件路径
#SBATCH --qos=high

MODEL_CONFIG="./model_configs/DeepSeek-R1-Distill-Qwen-1.5B.yaml"
# OUTPUT_DIR=data/evals/$MODEL
OUTPUT_DIR=/home/hywang/Reasoning/data/evals/$MODEL

lighteval sglang \
    $MODEL_CONFIG \
    "custom|aime24|0|0" \
    --custom-tasks src/open_r1/evaluate.py \
    --use-chat-template \
    --output-dir $OUTPUT_DIR