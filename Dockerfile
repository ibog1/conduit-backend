FROM python:3.6-slim

# System deps + netcat für DB wait
RUN apt-get update && apt-get install -y \
    sqlite3 \
    libpq-dev \
    gcc \
    netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5000

ENTRYPOINT ["./entrypoint.sh"]
