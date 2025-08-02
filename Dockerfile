FROM python:3.9-slim

# 永久禁用pip进度条和版本检查
ENV PIP_PROGRESS_BAR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PYTHONUNBUFFERED=1

WORKDIR /mimotions
COPY . .

# 使用独立命令确保环境变量生效
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir --no-input -r requirements.txt

CMD ["python", "main.py"]