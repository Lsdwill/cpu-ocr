# OCR Service - CPU Version / OCR Service - CPU版本

🚀 **High-performance CPU OCR text recognition service** - Built with FastAPI, supports multiple file formats for text recognition

🚀 **高性能CPU OCR文字识别服务** - 基于FastAPI构建，支持多种文件格式的文字识别

[English](#english) | [中文](#中文)

---

## English

### ✨ Features

- 🖥️ **Pure CPU Operation** - No GPU required, reduces deployment costs
- 📄 **Multi-format Support** - PDF, images, Excel, PowerPoint, etc.
- 🏗️ **Multi-architecture Support** - AMD64 and ARM64 (Apple Silicon)
- 🐳 **Docker Deployment** - Ready-to-use containerized solution
- ⚡ **High Performance** - Optimized recognition engine based on RapidOCR
- 🌐 **RESTful API** - Simple and easy-to-use HTTP interface
- 📊 **Health Check** - Built-in service monitoring and status checking

### 🎯 Supported File Formats

| Format Type | Supported Formats | Description |
|-------------|------------------|-------------|
| 📷 Images | JPG, PNG, BMP, TIFF | Common image formats |
| 📄 Documents | PDF | Multi-page PDF documents |
| 📊 Spreadsheets | XLSX, XLS | Excel spreadsheets |
| 📽️ Presentations | PPTX, PPT | PowerPoint presentations |

### 🚀 Quick Start

#### Method 1: Use Pre-built Images (Recommended)

```bash
# 1. Download Docker image package from GitHub Releases
# Visit: https://github.com/Lsdwill/cpu-ocr/releases
# AMD64: Download my-ocr-service-v1.0-amd64.tar.gz
# ARM64: Download my-ocr-service-v1.0-arm64.tar.gz

# 2. Load the image package
# AMD64
gunzip -c my-ocr-service-v1.0-amd64.tar.gz | docker load

# ARM64
gunzip -c my-ocr-service-v1.0-arm64.tar.gz | docker load

# 3. Start with corresponding docker-compose configuration
# AMD64
docker-compose -f docker-compose-amd64.yml up -d

# ARM64
docker-compose -f docker-compose-arm64.yml up -d
```

#### Method 2: Local Build

```bash
# Install dependencies
pip install -r requirements.txt

# Start service
python app.py
```

### 📡 API Usage

#### File Upload Recognition

```bash
curl -X POST \
  -F "file=@document.pdf" \
  http://localhost:9000/ocr
```

#### URL Recognition

```bash
curl -X POST \
  -H "Content-Type: application/json" \
  -d '{"url": "https://example.com/document.pdf"}' \
  http://localhost:9000/ocr/url
```

#### Health Check

```bash
curl http://localhost:9000/health
```

### 🏗️ Multi-architecture Support

#### AMD64 (x86_64)
For: Intel/AMD processor servers, PCs

```bash
docker build -t ocr-service:amd64 .
```

#### ARM64 (Apple Silicon)
For: Apple M1/M2 Macs, ARM servers

```bash
docker build -f Dockerfile.arm -t ocr-service:arm64 .
```

### 📊 Performance Metrics

| File Type | Average Processing Time | CPU Usage | Memory Usage |
|-----------|------------------------|-----------|--------------|
| Single-page PDF | ~2-3s | 60-80% | ~1GB |
| Image files | ~1-2s | 40-60% | ~800MB |
| Excel documents | ~0.5-1s | 20-40% | ~600MB |

*Test environment: 4-core CPU, 8GB RAM*

### 🛠️ Tech Stack

- **Web Framework**: FastAPI + Uvicorn
- **OCR Engine**: RapidOCR (ONNX Runtime)
- **Image Processing**: Pillow, OpenCV
- **Document Parsing**: pdf2image, openpyxl, python-pptx
- **Containerization**: Docker + Docker Compose

### 📁 Project Structure

```
├── app.py                    # Main application
├── requirements.txt          # Python dependencies
├── Dockerfile               # AMD64 build file
├── Dockerfile.arm           # ARM64 build file
├── docker-compose.yml       # Service orchestration
├── docker-compose-amd64.yml # AMD64 specific config
├── docker-compose-arm64.yml # ARM64 specific config
├── 多架构构建指南.md         # Build & deployment guide
└── example/
    └── test_resume.pdf      # Test file
```

### 🔧 Configuration

#### Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `TZ` | Asia/Shanghai | Timezone setting |
| `OMP_NUM_THREADS` | 4 | OpenMP thread count |
| `OPENBLAS_NUM_THREADS` | 4 | OpenBLAS thread count |

#### Resource Requirements

- **Minimum**: 2-core CPU, 2GB RAM
- **Recommended**: 4-core CPU, 4GB RAM
- **Disk Space**: 2GB available space

### 📖 Deployment Guide

#### Image Package Download and Usage

1. **Check System Architecture**
   ```bash
   uname -m
   # x86_64 -> Download AMD64 version
   # aarch64/arm64 -> Download ARM64 version
   ```

2. **Download from GitHub Releases**
   - Visit the project's [Releases page](../../releases)
   - Download the file for your architecture:
      - AMD64: `my-ocr-service-v1.0-amd64.tar.gz`
      - ARM64: `my-ocr-service-v1.0-arm64.tar.gz`

3. **Load and Start**
   ```bash
   # Load image
   gunzip -c my-ocr-service-v1.0-[architecture].tar.gz | docker load
   
   # Start service
   docker-compose -f docker-compose-[architecture].yml up -d
   ```

For detailed multi-architecture build and deployment instructions, see: [Multi-Architecture-Build-Guide.md](Multi-Architecture-Build-Guide.md)

### 🧪 Testing & Verification

```bash
# Health check
curl http://localhost:9000/health

# Function test
curl -X POST -F "file=@example/test_resume.pdf" http://localhost:9000/ocr
```

---

## 中文

### ✨ 特性

- 🖥️ **纯CPU运行** - 无需GPU，降低部署成本
- 📄 **多格式支持** - PDF、图片、Excel、PowerPoint等
- 🏗️ **多架构支持** - AMD64 和 ARM64 (Apple Silicon)
- 🐳 **Docker部署** - 开箱即用的容器化方案
- ⚡ **高性能** - 基于RapidOCR优化的识别引擎
- 🌐 **RESTful API** - 简单易用的HTTP接口
- 📊 **健康检查** - 内置服务监控和状态检查

### 🎯 支持的文件格式

| 格式类型 | 支持格式 | 说明 |
|---------|---------|------|
| 📷 图片 | JPG, PNG, BMP, TIFF | 常见图片格式 |
| 📄 文档 | PDF | 多页PDF文档 |
| 📊 表格 | XLSX, XLS | Excel电子表格 |
| 📽️ 演示 | PPTX, PPT | PowerPoint演示文稿 |

### 🚀 快速开始

#### 方法1：使用预构建镜像（推荐）

```bash
# 1. 从 GitHub Releases 下载对应架构的Docker镜像包
# 访问: https://github.com/Lsdwill/cpu-ocr/releases
# AMD64架构：下载 my-ocr-service-v1.0-amd64.tar.gz
# ARM64架构：下载 my-ocr-service-v1.0-arm64.tar.gz

# 2. 加载镜像包
# AMD64
gunzip -c my-ocr-service-v1.0-amd64.tar.gz | docker load

# ARM64  
gunzip -c my-ocr-service-v1.0-arm64.tar.gz | docker load

# 3. 使用对应的docker-compose配置启动
# AMD64
docker-compose -f docker-compose-amd64.yml up -d

# ARM64
docker-compose -f docker-compose-arm64.yml up -d
```

#### 方法2：本地构建

```bash
# 安装依赖
pip install -r requirements.txt

# 启动服务
python app.py
```

### 📡 API 使用

#### 文件上传识别

```bash
curl -X POST \
  -F "file=@document.pdf" \
  http://localhost:9000/ocr
```

#### URL识别

```bash
curl -X POST \
  -H "Content-Type: application/json" \
  -d '{"url": "https://example.com/document.pdf"}' \
  http://localhost:9000/ocr/url
```

#### 健康检查

```bash
curl http://localhost:9000/health
```

### 🏗️ 多架构支持

#### AMD64 (x86_64)
适用于：Intel/AMD处理器的服务器、PC

```bash
docker build -t ocr-service:amd64 .
```

#### ARM64 (Apple Silicon)
适用于：Apple M1/M2 Mac、ARM服务器

```bash
docker build -f Dockerfile.arm -t ocr-service:arm64 .
```

### 📊 性能表现

| 文件类型 | 平均处理时间 | CPU使用率 | 内存占用 |
|---------|-------------|-----------|----------|
| 单页PDF | ~2-3秒 | 60-80% | ~1GB |
| 图片文件 | ~1-2秒 | 40-60% | ~800MB |
| Excel文档 | ~0.5-1秒 | 20-40% | ~600MB |

*测试环境：4核CPU，8GB内存*

### 🛠️ 技术栈

- **Web框架**: FastAPI + Uvicorn
- **OCR引擎**: RapidOCR (ONNX Runtime)
- **图像处理**: Pillow, OpenCV
- **文档解析**: pdf2image, openpyxl, python-pptx
- **容器化**: Docker + Docker Compose

### 📁 项目结构

```
├── app.py                    # 主应用程序
├── requirements.txt          # Python依赖
├── Dockerfile               # AMD64构建文件
├── Dockerfile.arm           # ARM64构建文件
├── docker-compose.yml       # 服务编排
├── docker-compose-amd64.yml # AMD64专用配置
├── docker-compose-arm64.yml # ARM64专用配置
├── 多架构构建指南.md         # 构建部署指南
└── example/
    └── test_resume.pdf      # 测试文件
```

### 🔧 配置说明

#### 环境变量

| 变量名 | 默认值 | 说明 |
|--------|--------|------|
| `TZ` | Asia/Shanghai | 时区设置 |
| `OMP_NUM_THREADS` | 4 | OpenMP线程数 |
| `OPENBLAS_NUM_THREADS` | 4 | OpenBLAS线程数 |

#### 资源要求

- **最小配置**: 2核CPU, 2GB内存
- **推荐配置**: 4核CPU, 4GB内存
- **磁盘空间**: 2GB可用空间

### 📖 部署指南

#### 镜像包下载和使用

1. **检查系统架构**
   ```bash
   uname -m
   # x86_64 -> 下载 AMD64 版本
   # aarch64/arm64 -> 下载 ARM64 版本
   ```

2. **从 GitHub Releases 下载对应的镜像包**
   - 访问项目的 [Releases 页面](../../releases)
   - 下载对应架构的文件：
      - AMD64: `my-ocr-service-v1.0-amd64.tar.gz`
      - ARM64: `my-ocr-service-v1.0-arm64.tar.gz`

3. **加载和启动**
   ```bash
   # 加载镜像
   gunzip -c my-ocr-service-v1.0-[架构].tar.gz | docker load
   
   # 启动服务
   docker-compose -f docker-compose-[架构].yml up -d
   ```

详细的多架构构建和部署说明请参考：[多架构构建指南.md](多架构构建指南.md)

### 🧪 测试验证

```bash
# 健康检查
curl http://localhost:9000/health

# 功能测试
curl -X POST -F "file=@example/test_resume.pdf" http://localhost:9000/ocr
```

---

## 🤝 贡献 / Contributing

欢迎提交Issue和Pull Request！/ Welcome to submit Issues and Pull Requests!

1. Fork 项目 / Fork the project
2. 创建特性分支 / Create feature branch (`git checkout -b feature/AmazingFeature`)
3. 提交更改 / Commit changes (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 / Push to branch (`git push origin feature/AmazingFeature`)
5. 打开Pull Request / Open Pull Request

## 🙏 致谢 / Acknowledgments

- [RapidOCR](https://github.com/RapidAI/RapidOCR) - 优秀的OCR识别引擎 / Excellent OCR recognition engine
- [FastAPI](https://fastapi.tiangolo.com/) - 现代化的Web框架 / Modern web framework
- [Docker](https://www.docker.com/) - 容器化技术支持 / Containerization technology support

## 📞 支持 / Support

如果你觉得这个项目有用，请给个 ⭐ Star！/ If you find this project useful, please give it a ⭐ Star!

有问题或建议？欢迎提交 [Issue](../../issues) / Questions or suggestions? Welcome to submit an [Issue](../../issues)

---

**关键词 / Keywords**: OCR, 文字识别, CPU, Docker, FastAPI, 多架构, PDF识别, 图片识别, Text Recognition, Multi-architecture, PDF Recognition, Image Recognition