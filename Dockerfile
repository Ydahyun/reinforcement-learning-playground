FROM python:3.8-slim

WORKDIR /app

# 1. 시스템 패키지 + OpenGL + 가상 디스플레이 설치
RUN apt-get update && apt-get install -y \
    python3-dev \
    build-essential \
    ffmpeg \
    libsm6 \
    libxext6 \
    libgl1 \
    libglu1-mesa \
    xvfb \
    && rm -rf /var/lib/apt/lists/*

# 2. pip, setuptools, wheel 버전 호환성 맞춤 설치
RUN pip install --upgrade pip==22.3.1 setuptools==59.5.0 wheel==0.37.1

# 3. 필수 패키지 설치 (강화학습 + 시각화)
RUN pip install \
    gym==0.20 \
    numpy \
    matplotlib \
    pygame \
    pyglet==1.5.27 \
    torch==1.12.1 \
    torchvision==0.13.1 \
    torchaudio==0.12.1 \
    PyOpenGL \
    PyOpenGL_accelerate

# 4. 소스코드 복사
COPY . /app

# 5. xvfb를 통한 가상 디스플레이로 CartPole 실행
CMD ["xvfb-run", "-s", "-screen 0 1400x900x24", "python", "CartPole.py"]
