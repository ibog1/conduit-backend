FROM python:3.6-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    sqlite3 \
    libpq-dev \
    gcc \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy & install Python deps
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy source
COPY . .

EXPOSE 5000

CMD ["sh", "-c", "python manage.py migrate && gunicorn -w 4 -b 0.0.0.0:5000 conduit.wsgi:application"]
