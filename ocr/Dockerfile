FROM nvidia/cuda:12.2.0-base-ubuntu22.04

RUN apt-get update && apt-get install -y \
    python3 python3-pip git tesseract-ocr libtesseract-dev libgl1 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .
RUN pip install paddleocr

CMD ["python3", "-c", "import paddleocr; print('OCR container ready')"]
