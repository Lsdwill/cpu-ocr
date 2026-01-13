# Docker Multi-Architecture Build and Save Guide

## Overview

This guide specifically explains how to build and save Docker images for ARM64 and AMD64 architectures for the OCR service.

## Architecture Description

| Architecture | Docker Platform | Applicable Devices |
|--------------|-----------------|-------------------|
| AMD64 | linux/amd64 | Intel/AMD processor servers, PCs |
| ARM64 | linux/arm64 | Apple Silicon Mac, ARM servers, Raspberry Pi 4+ |

## Build and Save Images

### Method 1: Using buildx Build (Recommended)

#### AMD64 Architecture (buildx build + save)

```bash
# 1. Create and use buildx builder
docker buildx create --name multiarch-builder --use

# 2. Build AMD64 image
docker buildx build --platform linux/amd64 -t my-ocr-service:v1.0-amd64 --load .

# 3. Verify build results
docker images | grep my-ocr-service
docker inspect my-ocr-service:v1.0-amd64 | grep Architecture
# Should display: "Architecture": "amd64"

# 4. Save as compressed file (recommended)
docker save my-ocr-service:v1.0-amd64 | gzip > my-ocr-service-v1.0-amd64.tar.gz

# 5. Check file size
ls -lh my-ocr-service-v1.0-amd64.tar.gz
```

#### ARM64 Architecture (buildx build + save)

```bash
# 1. Create and use buildx builder (if not created)
docker buildx create --name multiarch-builder --use

# 2. Build ARM64 image
docker buildx build --platform linux/arm64 -f Dockerfile.arm -t my-ocr-service:v1.0-arm64 --load .

# 3. Verify build results
docker images | grep my-ocr-service
docker inspect my-ocr-service:v1.0-arm64 | grep Architecture
# Should display: "Architecture": "arm64"

# 4. Save as compressed file (recommended)
docker save my-ocr-service:v1.0-arm64 | gzip > my-ocr-service-v1.0-arm64.tar.gz

# 5. Check file size
ls -lh my-ocr-service-v1.0-arm64.tar.gz
```

### Method 2: Traditional Build Method

#### AMD64 Architecture (build + save)

```bash
# 1. Build AMD64 image (explicitly specify platform)
docker build --platform linux/amd64 -t my-ocr-service:v1.0-amd64 .

# 2. Verify build results
docker images | grep my-ocr-service
docker inspect my-ocr-service:v1.0-amd64 | grep Architecture
# Should display: "Architecture": "amd64"

# 3. Save as compressed file (recommended)
docker save my-ocr-service:v1.0-amd64 | gzip > my-ocr-service-v1.0-amd64.tar.gz

# 4. Check file size
ls -lh my-ocr-service-v1.0-amd64.tar.gz
```

#### ARM64 Architecture (build + save)

```bash
# 1. Build ARM64 image (explicitly specify platform)
docker build --platform linux/arm64 -f Dockerfile.arm -t my-ocr-service:v1.0-arm64 .

# 2. Verify build results
docker images | grep my-ocr-service
docker inspect my-ocr-service:v1.0-arm64 | grep Architecture
# Should display: "Architecture": "arm64"

# 3. Save as compressed file (recommended)
docker save my-ocr-service:v1.0-arm64 | gzip > my-ocr-service-v1.0-arm64.tar.gz

# 4. Check file size
ls -lh my-ocr-service-v1.0-arm64.tar.gz
```

## Load Images

### AMD64 Architecture Loading

```bash
# 1. Load AMD64 compressed image
gunzip -c my-ocr-service-v1.0-amd64.tar.gz | docker load

# 2. Verify loading results
docker images | grep my-ocr-service
docker inspect my-ocr-service:v1.0-amd64 | grep Architecture
# Should display: "Architecture": "amd64"

# 3. Start service (using AMD64 specific configuration)
docker-compose -f docker-compose-amd64.yml up -d

# 4. Test service
curl http://localhost:9000/health
```

### ARM64 Architecture Loading

```bash
# 1. Load ARM64 compressed image
gunzip -c my-ocr-service-v1.0-arm64.tar.gz | docker load

# 2. Verify loading results
docker images | grep my-ocr-service
docker inspect my-ocr-service:v1.0-arm64 | grep Architecture
# Should display: "Architecture": "arm64"

# 3. Start service (using ARM64 specific configuration)
docker-compose -f docker-compose-arm64.yml up -d

# 4. Test service
curl http://localhost:9000/health
```

### docker-compose.yml Configuration Examples

#### AMD64 Architecture Configuration (docker-compose-amd64.yml)

```yaml
version: '3.8'

services:
  ocr-server:
    image: my-ocr-service:v1.0-amd64
    
    container_name: ocr-server-amd64
    restart: always
    ports:
      - "9000:9000"

    environment:
      - TZ=Asia/Shanghai

    logging:
      driver: "json-file"
      options:
        max-size: "50m"
        max-file: "3"

    healthcheck:
      test: ["CMD-SHELL", "curl -f http://localhost:9000/health || exit 1"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 10s
```

#### ARM64 Architecture Configuration (docker-compose-arm64.yml)

```yaml
version: '3.8'

services:
  ocr-server:
    image: my-ocr-service:v1.0-arm64
    platform: linux/arm64  # Force specify platform
    
    container_name: ocr-server-arm64
    restart: always
    ports:
      - "9000:9000"

    environment:
      - TZ=Asia/Shanghai
      # ARM optimization configuration
      - OMP_NUM_THREADS=4
      - OPENBLAS_NUM_THREADS=4

    logging:
      driver: "json-file"
      options:
        max-size: "50m"
        max-file: "3"

    healthcheck:
      test: ["CMD-SHELL", "curl -f http://localhost:9000/health || exit 1"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 15s  # ARM startup might be slower

    # ARM platform resource limits
    deploy:
      resources:
        limits:
          memory: 2G
        reservations:
          memory: 1G
```

#### Using Different Architecture Configuration Files

```bash
# AMD64 architecture startup
docker-compose -f docker-compose-amd64.yml up -d

# ARM64 architecture startup
docker-compose -f docker-compose-arm64.yml up -d

# Check service status
docker-compose -f docker-compose-amd64.yml ps
docker-compose -f docker-compose-arm64.yml ps

# Stop service
docker-compose -f docker-compose-amd64.yml down
docker-compose -f docker-compose-arm64.yml down
```

### Load Uncompressed Images

```bash
# If using .tar files (uncompressed)
docker load -i my-ocr-service-v1.0-amd64.tar
docker load -i my-ocr-service-v1.0-arm64.tar

# Verify loaded image architecture
docker inspect my-ocr-service:v1.0-amd64 | grep Architecture
docker inspect my-ocr-service:v1.0-arm64 | grep Architecture

# Start service using corresponding configuration files
docker-compose -f docker-compose-amd64.yml up -d  # AMD64
docker-compose -f docker-compose-arm64.yml up -d  # ARM64
```

### Check System Architecture

```bash
# Check current system architecture
uname -m

# x86_64    -> Use AMD64 images
# aarch64   -> Use ARM64 images  
# arm64     -> Use ARM64 images
```

## Usage Instructions

### 1. Preparation

Ensure the following files exist:
- `Dockerfile` (AMD64 version)
- `Dockerfile.arm` (ARM64 version)
- `requirements.txt`
- `app.py`

### 2. Execute Build

Choose the appropriate method based on your needs:
- **Method 1 (Recommended)**: Use buildx for cross-platform builds
- **Method 2**: Use traditional build method

### 3. Verify Results

```bash
# Check generated files
ls -lh *.tar.gz

# Verify image content
docker load -i my-ocr-service-v1.0-amd64.tar.gz
docker images | grep my-ocr-service
```

## Notes

1. **Build Time**: ARM64 image build time is usually 20-50% longer than AMD64
2. **File Size**: Image sizes for different architectures may vary slightly
3. **Dependency Compatibility**: Ensure all Python packages support the target architecture
4. **Test Verification**: Recommend testing on corresponding architecture devices after build completion

## Troubleshooting

### Common Issues

1. **Architecture Mismatch Error (exec format error)**
   ```bash
   # Problem: Running AMD64 image on ARM64 system, or vice versa
   # Solution: Check actual image architecture
   docker inspect my-ocr-service:v1.0-arm64 | grep Architecture
   
   # If architecture doesn't match, rebuild correct architecture image
   docker rmi my-ocr-service:v1.0-arm64
   docker buildx build --platform linux/arm64 -f Dockerfile.arm -t my-ocr-service:v1.0-arm64 --load .
   ```

2. **Build Architecture Error**
   ```bash
   # Problem: Using Dockerfile.arm to build but architecture is still amd64
   # Solution: Explicitly specify target platform
   docker buildx build --platform linux/arm64 -f Dockerfile.arm -t my-ocr-service:v1.0-arm64 --load .
   
   # Or use buildx with explicit platform
   docker buildx create --name multiarch-builder --use
   docker buildx build --platform linux/arm64 -f Dockerfile.arm -t my-ocr-service:v1.0-arm64 --load .
   ```

3. **Build Failure**
   ```bash
   # Clear build cache
   docker builder prune -f
   
   # Rebuild (no cache)
   docker buildx build --no-cache --platform linux/amd64 -t my-ocr-service:v1.0-amd64 --load .
   docker buildx build --no-cache --platform linux/arm64 -f Dockerfile.arm -t my-ocr-service:v1.0-arm64 --load .
   ```

4. **Save Failure**
   ```bash
   # Check disk space
   df -h
   
   # Clean unused images
   docker image prune -f
   ```

5. **Image Package Verification**
   ```bash
   # Check image architecture
   docker inspect my-ocr-service:v1.0-amd64 | grep Architecture
   docker inspect my-ocr-service:v1.0-arm64 | grep Architecture
   
   # Check image size
   docker images | grep my-ocr-service
   ```

### Architecture Verification Checklist

Before building and deploying, please confirm:

1. **System Architecture Check**
   ```bash
   uname -m
   # x86_64 -> Need AMD64 image
   # aarch64 -> Need ARM64 image
   ```

2. **Image Architecture Verification**
   ```bash
   docker inspect [image-name] | grep Architecture
   # Ensure image architecture matches system architecture
   ```

3. **Configuration File Selection**
   ```bash
   # AMD64 system use
   docker-compose -f docker-compose-amd64.yml up -d
   
   # ARM64 system use
   docker-compose -f docker-compose-arm64.yml up -d
   ```

### Performance Optimization Recommendations

1. **ARM64 Platform Optimization**
   - Set appropriate thread count: `OMP_NUM_THREADS=4`
   - Limit memory usage: Maximum 2GB
   - Increase startup wait time: 15 seconds

2. **Build Optimization**
   - Use multi-stage builds to reduce image size
   - Reasonable use of build cache
   - Clean unnecessary dependency packages

3. **buildx Advantages**
   - Better cross-platform support
   - More reliable architecture specification
   - Support for simultaneous multi-architecture builds
   - Better handling of platform-specific dependencies