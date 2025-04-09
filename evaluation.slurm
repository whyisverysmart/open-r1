#!/bin/bash

#SBATCH --account=hywang
#SBATCH --job-name=reasoning
#SBATCH --partition=A100 # 用sinfo命令可以看到所有队列
#SBATCH --nodes=1           # 申请的节点数量，单机训练无需调整
#SBATCH --ntasks-per-node=1 # 若多卡或多进程，请调整此参数
#SBATCH --cpus-per-task=4  # 每个进程的CPU数量
#SBATCH --gres=gpu:1        # 若使用2块卡，则gres=gpu:2
#SBATCH --output=../lumia-output/%j.out     # 设置标准输出的文件路径
#SBATCH --error=../lumia-output/%j.err      # 设置标准错误的文件路径
#SBATCH --qos=high

export PATH=/data1/public/cuda/cuda-12.4/bin:$PATH
export LD_LIBRARY_PATH=/data1/public/cuda/cuda-12.4/lib64/:$LD_LIBRARY_PATH
export HF_ENDPOINT=https://hf-mirror.com

MODEL_CONFIG="./model_configs/DeepSeek-R1-Distill-Qwen-1.5B.yaml"
# MODEL_CONFIG="./model_configs/DeepSeek-R1-Distill-Qwen-7B.yaml"

# lighteval sglang \
#     $MODEL_CONFIG \
#     "custom|aime24|0|0" \
#     --custom-tasks src/open_r1/evaluate.py \
#     --use-chat-template \
#     --output-dir /home/hywang/Reasoning/lighteval_results/aime24

lighteval sglang \
    $MODEL_CONFIG \
    "custom|math_500|0|0" \
    --custom-tasks src/open_r1/evaluate.py \
    --use-chat-template \
    --output-dir /home/hywang/Reasoning/lighteval_results/math_500

# lighteval sglang \
#     $MODEL_CONFIG \
#     "custom|gpqa:diamond|0|0" \
#     --custom-tasks src/open_r1/evaluate.py \
#     --use-chat-template \
#     --output-dir /home/hywang/Reasoning/lighteval_results/gpqa_diamond