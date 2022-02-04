FROM python:3.7-slim-stretch

WORKDIR /app

COPY requirements.txt .

RUN python -m pip install -r requirements.txt

COPY . .

ENTRYPOINT ["python", "app.py"]
