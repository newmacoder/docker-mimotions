# docker执行微信刷运动步数



## 服务器时间要设置为北京时间

```
sudo timedatectl set-timezone Asia/Shanghai
sudo timedatectl set-ntp true
timedatectl
date
```



## 创建config.yaml文件

```
user: "user@abc.com"
password: "mypassword"
step_min: 10000
step_max: 15000
```

## 创建Dockerfile

```
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
```



## 运行容器

```
docker build -t mimotions .
docker run mimotions
docker run --rm mimotions
```



## 服务器定时运行容器

**配置系统定时任务**

```
sudo crontab -e
```

**添加以下内容（每天18点执行）**

```
# 每天18点运行容器，并记录日志
0 18 * * * /usr/bin/docker run --rm mimotions >> /var/log/mimotions.log 2>&1
```

- `0 2 * * *`：每天18点
- `> /var/log/mimotions.log`：输出日志到文件
- `2>&1`：将错误输出重定向到标准输出

