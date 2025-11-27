FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY join.py .
COPY data.py .

#  для монтирования
RUN mkdir -p /app/input /app/output

CMD ["sh", "-c", "python data.py && python join.py"]
