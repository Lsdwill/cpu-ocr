FROM python:3.10-slim

WORKDIR /app

# 1. 替换阿里源加速
RUN pip config set global.index-url https://mirrors.aliyun.com/pypi/simple/

# 2. 安装系统依赖
# 增加 libgl1 和 libglib2.0-0 解决 cv2 缺库问题
RUN apt-get update && \
    apt-get install -y --no-install-recommends libgomp1 poppler-utils catdoc libgl1 libglib2.0-0 && \
    rm -rf /var/lib/apt/lists/*

# 3. 安装 Python 库
RUN pip install --no-cache-dir \
    fastapi uvicorn websockets \
    rapidocr-onnxruntime \
    numpy requests \
    python-pptx openpyxl xlrd \
    pdf2image Pillow python-multipart

# 4. 复制代码
COPY . .

EXPOSE 9000

# 确保这里是 app.py
CMD ["python", "app.py"]